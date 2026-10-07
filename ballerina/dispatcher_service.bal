// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/crypto;
import ballerina/http;
import ballerina/log;
import ballerina/time;
import ballerinax/asyncapi.native.handler;

service class DispatcherService {
    *http:Service;
    private map<GenericServiceType> services = {};
    private handler:NativeHandler nativeHandler = new ();
    private string? webhookSecret;
    private string callbackUrl;

    function init(string? webhookSecret, string callbackUrl) {
        self.webhookSecret = webhookSecret;
        self.callbackUrl = callbackUrl;
    }

    isolated function addServiceRef(string serviceType, GenericServiceType genericService) returns error? {
        if (self.services.hasKey(serviceType)) {
            return error(string `Service of type ${serviceType} has already been attached`);
        }
        self.services[serviceType] = genericService;
    }

    isolated function removeServiceRef(string serviceType) returns error? {
        if (!self.services.hasKey(serviceType)) {
            return error(string `Cannot detach the service of type ${serviceType}. Service has not been attached to the listener before`);
        }
        _ = self.services.remove(serviceType);
    }

    resource function post .(http:Caller caller, http:Request request) returns error? {
        error? verifyResult = self.verifyWebhookSignature(request, self.webhookSecret);
        if verifyResult is error {
            http:Response r = new;
            r.statusCode = http:STATUS_UNAUTHORIZED;
            check caller->respond(r);
            return;
        }
        json payload = check request.getJsonPayload();
        json[] eventsArray = check payload.ensureType();
        http:Response ackResponse = new;
        ackResponse.statusCode = http:STATUS_OK;
        check caller->respond(ackResponse);
        _ = start self.dispatchBatchedEvents(eventsArray, "");
    }

    isolated function dispatchBatchedEvents(json[] eventsArray, string eventType) returns error? {
        foreach json event in eventsArray {
            json|error eventTypeField = event.subscriptionType;
            if eventTypeField is error {
                log:printError("DISPATCH_FAILED", eventTypeField);
                continue;
            }
            string elementEventType = eventTypeField.toString();
            boolean|error dispatchResult = self.matchRemoteFunc(event, elementEventType);
            if dispatchResult is error {
                log:printError("DISPATCH_FAILED", dispatchResult);
            } else if !dispatchResult {
                log:printWarn("NO_HANDLER_FOR_EVENT", eventIdentifier = elementEventType);
            }
        }
    }

    private isolated function verifyWebhookSignature(http:Request request, string? webhookSecret) returns error? {
        if webhookSecret is () {
            return error("Unauthorized: Webhook Secret Not Configured");
        }
        if !request.hasHeader("X-HubSpot-Request-Timestamp") {
            return error("Unauthorized: Missing Freshness Header");
        }
        string freshnessHeaderValue = check request.getHeader("X-HubSpot-Request-Timestamp");
        decimal freshnessTimestamp = check decimal:fromString(freshnessHeaderValue);
        decimal freshnessNowMillis = <decimal>time:utcNow()[0] * 1000;
        decimal freshnessSkewMillis = freshnessNowMillis - freshnessTimestamp;
        if freshnessSkewMillis.abs() > 300000d {
            return error("Unauthorized: Request Timestamp Expired");
        }
        if !request.hasHeader("X-HubSpot-Signature-v3") {
            return error("Unauthorized: Missing Signature Header");
        }
        string receivedHeader = check request.getHeader("X-HubSpot-Signature-v3");
        map<string> extractedHeaderValues = {};
        int headerCursor = 0;
        extractedHeaderValues["signature"] = receivedHeader.substring(headerCursor);
        headerCursor = receivedHeader.length();
        if !extractedHeaderValues.hasKey("signature") {
            return error("Unauthorized: Missing Header Component: signature");
        }
        string payloadToHash = string `${request.method}${self.callbackUrl}${check request.getTextPayload()}${check request.getHeader("X-HubSpot-Request-Timestamp")}`;
        byte[] computedDigest = check crypto:hmacSha256(payloadToHash.toBytes(), webhookSecret.toBytes());
        string computedSignature = computedDigest.toBase64();
        string expectedHeader = string `${computedSignature}`;
        if !crypto:equalConstantTime(receivedHeader.toBytes(), expectedHeader.toBytes()) {
            return error("Unauthorized: Signature Mismatch");
        }
    }

    private isolated function matchRemoteFunc(json payload, string eventType) returns boolean|error {
        if check self.matchRemoteFuncForTicket(payload) {
            return true;
        }
        if check self.matchRemoteFuncForCompany(payload) {
            return true;
        }
        if check self.matchRemoteFuncForLineItem(payload) {
            return true;
        }
        if check self.matchRemoteFuncForProduct(payload) {
            return true;
        }
        if check self.matchRemoteFuncForConversation(payload) {
            return true;
        }
        if check self.matchRemoteFuncForDeal(payload) {
            return true;
        }
        if check self.matchRemoteFuncForContact(payload) {
            return true;
        }
        return false;
    }

    private isolated function matchRemoteFuncForTicket(json payload) returns boolean|error {
        match payload.subscriptionType {
            "ticket.propertyChange" => {
                check self.executeRemoteFunc(payload, "ticket.propertyChange", "TicketService", "onTicketPropertyChange");
                return true;
            }
            "ticket.deletion" => {
                check self.executeRemoteFunc(payload, "ticket.deletion", "TicketService", "onTicketDeletion");
                return true;
            }
            "ticket.creation" => {
                check self.executeRemoteFunc(payload, "ticket.creation", "TicketService", "onTicketCreation");
                return true;
            }
            "ticket.merge" => {
                check self.executeRemoteFunc(payload, "ticket.merge", "TicketService", "onTicketMerge");
                return true;
            }
            "ticket.restore" => {
                check self.executeRemoteFunc(payload, "ticket.restore", "TicketService", "onTicketRestore");
                return true;
            }
            "ticket.associationChange" => {
                check self.executeRemoteFunc(payload, "ticket.associationChange", "TicketService", "onTicketAssociationChange");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForCompany(json payload) returns boolean|error {
        match payload.subscriptionType {
            "company.deletion" => {
                check self.executeRemoteFunc(payload, "company.deletion", "CompanyService", "onCompanyDeletion");
                return true;
            }
            "company.restore" => {
                check self.executeRemoteFunc(payload, "company.restore", "CompanyService", "onCompanyRestore");
                return true;
            }
            "company.merge" => {
                check self.executeRemoteFunc(payload, "company.merge", "CompanyService", "onCompanyMerge");
                return true;
            }
            "company.propertyChange" => {
                check self.executeRemoteFunc(payload, "company.propertyChange", "CompanyService", "onCompanyPropertyChange");
                return true;
            }
            "company.creation" => {
                check self.executeRemoteFunc(payload, "company.creation", "CompanyService", "onCompanyCreation");
                return true;
            }
            "company.associationChange" => {
                check self.executeRemoteFunc(payload, "company.associationChange", "CompanyService", "onCompanyAssociationChange");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForLineItem(json payload) returns boolean|error {
        match payload.subscriptionType {
            "line_item.merge" => {
                check self.executeRemoteFunc(payload, "line_item.merge", "LineItemService", "onLineItemMerge");
                return true;
            }
            "line_item.deletion" => {
                check self.executeRemoteFunc(payload, "line_item.deletion", "LineItemService", "onLineItemDeletion");
                return true;
            }
            "line_item.propertyChange" => {
                check self.executeRemoteFunc(payload, "line_item.propertyChange", "LineItemService", "onLineItemPropertyChange");
                return true;
            }
            "line_item.restore" => {
                check self.executeRemoteFunc(payload, "line_item.restore", "LineItemService", "onLineItemRestore");
                return true;
            }
            "line_item.associationChange" => {
                check self.executeRemoteFunc(payload, "line_item.associationChange", "LineItemService", "onLineItemAssociationChange");
                return true;
            }
            "line_item.creation" => {
                check self.executeRemoteFunc(payload, "line_item.creation", "LineItemService", "onLineItemCreation");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForProduct(json payload) returns boolean|error {
        match payload.subscriptionType {
            "product.propertyChange" => {
                check self.executeRemoteFunc(payload, "product.propertyChange", "ProductService", "onProductPropertyChange");
                return true;
            }
            "product.deletion" => {
                check self.executeRemoteFunc(payload, "product.deletion", "ProductService", "onProductDeletion");
                return true;
            }
            "product.merge" => {
                check self.executeRemoteFunc(payload, "product.merge", "ProductService", "onProductMerge");
                return true;
            }
            "product.restore" => {
                check self.executeRemoteFunc(payload, "product.restore", "ProductService", "onProductRestore");
                return true;
            }
            "product.creation" => {
                check self.executeRemoteFunc(payload, "product.creation", "ProductService", "onProductCreation");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForConversation(json payload) returns boolean|error {
        match payload.subscriptionType {
            "conversation.creation" => {
                check self.executeRemoteFunc(payload, "conversation.creation", "ConversationService", "onConversationCreation");
                return true;
            }
            "conversation.propertyChange" => {
                check self.executeRemoteFunc(payload, "conversation.propertyChange", "ConversationService", "onConversationPropertyChange");
                return true;
            }
            "conversation.privacyDeletion" => {
                check self.executeRemoteFunc(payload, "conversation.privacyDeletion", "ConversationService", "onConversationPrivacyDeletion");
                return true;
            }
            "conversation.newMessage" => {
                check self.executeRemoteFunc(payload, "conversation.newMessage", "ConversationService", "onConversationNewMessage");
                return true;
            }
            "conversation.deletion" => {
                check self.executeRemoteFunc(payload, "conversation.deletion", "ConversationService", "onConversationDeletion");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForDeal(json payload) returns boolean|error {
        match payload.subscriptionType {
            "deal.deletion" => {
                check self.executeRemoteFunc(payload, "deal.deletion", "DealService", "onDealDeletion");
                return true;
            }
            "deal.creation" => {
                check self.executeRemoteFunc(payload, "deal.creation", "DealService", "onDealCreation");
                return true;
            }
            "deal.merge" => {
                check self.executeRemoteFunc(payload, "deal.merge", "DealService", "onDealMerge");
                return true;
            }
            "deal.propertyChange" => {
                check self.executeRemoteFunc(payload, "deal.propertyChange", "DealService", "onDealPropertyChange");
                return true;
            }
            "deal.restore" => {
                check self.executeRemoteFunc(payload, "deal.restore", "DealService", "onDealRestore");
                return true;
            }
            "deal.associationChange" => {
                check self.executeRemoteFunc(payload, "deal.associationChange", "DealService", "onDealAssociationChange");
                return true;
            }
        }
        return false;
    }

    private isolated function matchRemoteFuncForContact(json payload) returns boolean|error {
        match payload.subscriptionType {
            "contact.creation" => {
                check self.executeRemoteFunc(payload, "contact.creation", "ContactService", "onContactCreation");
                return true;
            }
            "contact.associationChange" => {
                check self.executeRemoteFunc(payload, "contact.associationChange", "ContactService", "onContactAssociationChange");
                return true;
            }
            "contact.deletion" => {
                check self.executeRemoteFunc(payload, "contact.deletion", "ContactService", "onContactDeletion");
                return true;
            }
            "contact.privacyDeletion" => {
                check self.executeRemoteFunc(payload, "contact.privacyDeletion", "ContactService", "onContactPrivacyDeletion");
                return true;
            }
            "contact.propertyChange" => {
                check self.executeRemoteFunc(payload, "contact.propertyChange", "ContactService", "onContactPropertyChange");
                return true;
            }
            "contact.merge" => {
                check self.executeRemoteFunc(payload, "contact.merge", "ContactService", "onContactMerge");
                return true;
            }
            "contact.restore" => {
                check self.executeRemoteFunc(payload, "contact.restore", "ContactService", "onContactRestore");
                return true;
            }
        }
        return false;
    }

    private isolated function executeRemoteFunc(json payload, string eventName, string serviceTypeStr, string eventFunction) returns error? {
        GenericServiceType? genericService = self.services[serviceTypeStr];
        if genericService is GenericServiceType {
            any boundEvent = check self.nativeHandler.bindEventPayload(genericService, eventFunction, payload);
            check self.nativeHandler.invokeRemoteFunction(boundEvent, eventName, eventFunction, genericService);
        } else {
            log:printDebug("SERVICE_NOT_ATTACHED", serviceType = serviceTypeStr, eventName = eventName);
        }
    }
}
