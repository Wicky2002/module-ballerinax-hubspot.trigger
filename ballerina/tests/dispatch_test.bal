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
import ballerina/data.jsondata;
import ballerina/http;
import ballerina/io;
import ballerina/lang.runtime;
import ballerina/test;
import ballerina/time;

const TRIGGER_TEST_SECRET = "trigger-test-secret";
const TRIGGER_TEST_PORT = 9091;
const TRIGGER_PAYLOAD_DIR = "tests/resources/trigger_payloads";
const TRIGGER_TEST_CALLBACK_URL = "test-callbackUrl-value";

isolated map<boolean> triggerFired = {};
isolated map<json> boundPayloads = {};
isolated map<json> boundJson = {};

listener Listener triggerTestListener = check new ({webhookSecret: TRIGGER_TEST_SECRET, callbackUrl: TRIGGER_TEST_CALLBACK_URL}, TRIGGER_TEST_PORT);

final http:Client triggerClient = check new (string `http://localhost:${TRIGGER_TEST_PORT}`);

service CompanyService on triggerTestListener {
    isolated remote function onCompanyCreation(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["CompanyService.onCompanyCreation"] = received;
        }
        lock {
            triggerFired["CompanyService.onCompanyCreation"] = true;
        }
    }

    isolated remote function onCompanyDeletion(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["CompanyService.onCompanyDeletion"] = received;
        }
        lock {
            triggerFired["CompanyService.onCompanyDeletion"] = true;
        }
    }

    isolated remote function onCompanyPropertyChange(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["CompanyService.onCompanyPropertyChange"] = received;
        }
        lock {
            triggerFired["CompanyService.onCompanyPropertyChange"] = true;
        }
    }

    isolated remote function onCompanyAssociationChange(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["CompanyService.onCompanyAssociationChange"] = received;
        }
        lock {
            triggerFired["CompanyService.onCompanyAssociationChange"] = true;
        }
    }

    isolated remote function onCompanyMerge(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["CompanyService.onCompanyMerge"] = received;
        }
        lock {
            triggerFired["CompanyService.onCompanyMerge"] = true;
        }
    }

    isolated remote function onCompanyRestore(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["CompanyService.onCompanyRestore"] = received;
        }
        lock {
            triggerFired["CompanyService.onCompanyRestore"] = true;
        }
    }
}

service ContactService on triggerTestListener {
    isolated remote function onContactCreation(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ContactService.onContactCreation"] = received;
        }
        lock {
            triggerFired["ContactService.onContactCreation"] = true;
        }
    }

    isolated remote function onContactDeletion(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ContactService.onContactDeletion"] = received;
        }
        lock {
            triggerFired["ContactService.onContactDeletion"] = true;
        }
    }

    isolated remote function onContactPropertyChange(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ContactService.onContactPropertyChange"] = received;
        }
        lock {
            triggerFired["ContactService.onContactPropertyChange"] = true;
        }
    }

    isolated remote function onContactAssociationChange(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ContactService.onContactAssociationChange"] = received;
        }
        lock {
            triggerFired["ContactService.onContactAssociationChange"] = true;
        }
    }

    isolated remote function onContactMerge(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ContactService.onContactMerge"] = received;
        }
        lock {
            triggerFired["ContactService.onContactMerge"] = true;
        }
    }

    isolated remote function onContactRestore(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ContactService.onContactRestore"] = received;
        }
        lock {
            triggerFired["ContactService.onContactRestore"] = true;
        }
    }

    isolated remote function onContactPrivacyDeletion(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ContactService.onContactPrivacyDeletion"] = received;
        }
        lock {
            triggerFired["ContactService.onContactPrivacyDeletion"] = true;
        }
    }
}

service ConversationService on triggerTestListener {
    isolated remote function onConversationCreation(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ConversationService.onConversationCreation"] = received;
        }
        lock {
            triggerFired["ConversationService.onConversationCreation"] = true;
        }
    }

    isolated remote function onConversationDeletion(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ConversationService.onConversationDeletion"] = received;
        }
        lock {
            triggerFired["ConversationService.onConversationDeletion"] = true;
        }
    }

    isolated remote function onConversationPropertyChange(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ConversationService.onConversationPropertyChange"] = received;
        }
        lock {
            triggerFired["ConversationService.onConversationPropertyChange"] = true;
        }
    }

    isolated remote function onConversationPrivacyDeletion(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ConversationService.onConversationPrivacyDeletion"] = received;
        }
        lock {
            triggerFired["ConversationService.onConversationPrivacyDeletion"] = true;
        }
    }

    isolated remote function onConversationNewMessage(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ConversationService.onConversationNewMessage"] = received;
        }
        lock {
            triggerFired["ConversationService.onConversationNewMessage"] = true;
        }
    }
}

service DealService on triggerTestListener {
    isolated remote function onDealCreation(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["DealService.onDealCreation"] = received;
        }
        lock {
            triggerFired["DealService.onDealCreation"] = true;
        }
    }

    isolated remote function onDealDeletion(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["DealService.onDealDeletion"] = received;
        }
        lock {
            triggerFired["DealService.onDealDeletion"] = true;
        }
    }

    isolated remote function onDealPropertyChange(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["DealService.onDealPropertyChange"] = received;
        }
        lock {
            triggerFired["DealService.onDealPropertyChange"] = true;
        }
    }

    isolated remote function onDealAssociationChange(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["DealService.onDealAssociationChange"] = received;
        }
        lock {
            triggerFired["DealService.onDealAssociationChange"] = true;
        }
    }

    isolated remote function onDealMerge(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["DealService.onDealMerge"] = received;
        }
        lock {
            triggerFired["DealService.onDealMerge"] = true;
        }
    }

    isolated remote function onDealRestore(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["DealService.onDealRestore"] = received;
        }
        lock {
            triggerFired["DealService.onDealRestore"] = true;
        }
    }
}

service TicketService on triggerTestListener {
    isolated remote function onTicketCreation(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["TicketService.onTicketCreation"] = received;
        }
        lock {
            triggerFired["TicketService.onTicketCreation"] = true;
        }
    }

    isolated remote function onTicketDeletion(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["TicketService.onTicketDeletion"] = received;
        }
        lock {
            triggerFired["TicketService.onTicketDeletion"] = true;
        }
    }

    isolated remote function onTicketPropertyChange(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["TicketService.onTicketPropertyChange"] = received;
        }
        lock {
            triggerFired["TicketService.onTicketPropertyChange"] = true;
        }
    }

    isolated remote function onTicketAssociationChange(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["TicketService.onTicketAssociationChange"] = received;
        }
        lock {
            triggerFired["TicketService.onTicketAssociationChange"] = true;
        }
    }

    isolated remote function onTicketMerge(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["TicketService.onTicketMerge"] = received;
        }
        lock {
            triggerFired["TicketService.onTicketMerge"] = true;
        }
    }

    isolated remote function onTicketRestore(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["TicketService.onTicketRestore"] = received;
        }
        lock {
            triggerFired["TicketService.onTicketRestore"] = true;
        }
    }
}

service ProductService on triggerTestListener {
    isolated remote function onProductCreation(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ProductService.onProductCreation"] = received;
        }
        lock {
            triggerFired["ProductService.onProductCreation"] = true;
        }
    }

    isolated remote function onProductDeletion(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ProductService.onProductDeletion"] = received;
        }
        lock {
            triggerFired["ProductService.onProductDeletion"] = true;
        }
    }

    isolated remote function onProductPropertyChange(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ProductService.onProductPropertyChange"] = received;
        }
        lock {
            triggerFired["ProductService.onProductPropertyChange"] = true;
        }
    }

    isolated remote function onProductMerge(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ProductService.onProductMerge"] = received;
        }
        lock {
            triggerFired["ProductService.onProductMerge"] = true;
        }
    }

    isolated remote function onProductRestore(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["ProductService.onProductRestore"] = received;
        }
        lock {
            triggerFired["ProductService.onProductRestore"] = true;
        }
    }
}

service LineItemService on triggerTestListener {
    isolated remote function onLineItemCreation(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["LineItemService.onLineItemCreation"] = received;
        }
        lock {
            triggerFired["LineItemService.onLineItemCreation"] = true;
        }
    }

    isolated remote function onLineItemDeletion(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["LineItemService.onLineItemDeletion"] = received;
        }
        lock {
            triggerFired["LineItemService.onLineItemDeletion"] = true;
        }
    }

    isolated remote function onLineItemPropertyChange(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["LineItemService.onLineItemPropertyChange"] = received;
        }
        lock {
            triggerFired["LineItemService.onLineItemPropertyChange"] = true;
        }
    }

    isolated remote function onLineItemAssociationChange(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["LineItemService.onLineItemAssociationChange"] = received;
        }
        lock {
            triggerFired["LineItemService.onLineItemAssociationChange"] = true;
        }
    }

    isolated remote function onLineItemMerge(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["LineItemService.onLineItemMerge"] = received;
        }
        lock {
            triggerFired["LineItemService.onLineItemMerge"] = true;
        }
    }

    isolated remote function onLineItemRestore(WebhookEvent payload) returns error? {
        readonly & json received = jsondata:toJson(payload).cloneReadOnly();
        lock {
            boundJson["LineItemService.onLineItemRestore"] = received;
        }
        lock {
            triggerFired["LineItemService.onLineItemRestore"] = true;
        }
    }
}

isolated function sendSignedTriggerWebhook(string eventIdentifier) returns http:Response|error {
    byte[] body = check io:fileReadBytes(string `${TRIGGER_PAYLOAD_DIR}/${eventIdentifier}.json`);
    string bodyText = check string:fromBytes(body);
    string xHubspotRequestTimestampHeaderValue = (time:utcNow()[0] * 1000).toString();
    string payloadToHash = string `${"POST"}${TRIGGER_TEST_CALLBACK_URL}${bodyText}${xHubspotRequestTimestampHeaderValue}`;
    byte[] computedDigest = check crypto:hmacSha256(payloadToHash.toBytes(), TRIGGER_TEST_SECRET.toBytes());
    string computedSignature = computedDigest.toBase64();
    map<string> headers = {
        "X-HubSpot-Request-Timestamp": xHubspotRequestTimestampHeaderValue,
        "X-HubSpot-Signature-v3": string `${computedSignature}`
    };
    return triggerClient->post("/", body, headers, "application/json");
}

function waitForDispatch(string trackerKey) returns boolean {
    foreach int i in 0 ..< 20 {
        lock {
            if triggerFired[trackerKey] ?: false {
                return true;
            }
        }
        runtime:sleep(0.05);
    }
    return false;
}

function boundJsonOf(string trackerKey) returns json {
    lock {
        return boundJson[trackerKey].clone();
    }
}

function deliveredEvent(json bound, json fixture) returns json {
    return fixture is json[] && fixture.length() == 1 && bound is map<json>
        ? fixture[0] : fixture;
}

function assertBindsFixture(json bound, json fixture, string at) {
    if fixture is map<json> {
        test:assertTrue(bound is map<json>, string `${at} should have bound to an object`);
        if bound is map<json> {
            foreach [string, json] [key, value] in fixture.entries() {
                assertBindsFixture(bound[key], value, string `${at}.${key}`);
            }
        }
    } else if fixture is json[] {
        test:assertTrue(bound is json[] && bound.length() == fixture.length(),
                string `${at} should have bound to an array of ${fixture.length()}`);
        if bound is json[] && bound.length() == fixture.length() {
            foreach int i in 0 ..< fixture.length() {
                assertBindsFixture(bound[i], fixture[i], string `${at}[${i}]`);
            }
        }
    } else if fixture is int|float|decimal && bound is int|float|decimal {
        test:assertEquals(<decimal>bound, <decimal>fixture,
                string `${at} should have bound unchanged`);
    } else {
        test:assertEquals(bound, fixture,
                string `${at} should have bound unchanged`);
    }
}

@test:Config {}
function testCompanyCreationDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("company.creation");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CompanyService.onCompanyCreation"), "CompanyService.onCompanyCreation should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/company.creation.json`);
    json received = boundJsonOf("CompanyService.onCompanyCreation");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testCompanyDeletionDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("company.deletion");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CompanyService.onCompanyDeletion"), "CompanyService.onCompanyDeletion should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/company.deletion.json`);
    json received = boundJsonOf("CompanyService.onCompanyDeletion");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testCompanyPropertyChangeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("company.propertyChange");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CompanyService.onCompanyPropertyChange"), "CompanyService.onCompanyPropertyChange should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/company.propertyChange.json`);
    json received = boundJsonOf("CompanyService.onCompanyPropertyChange");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testCompanyAssociationChangeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("company.associationChange");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CompanyService.onCompanyAssociationChange"), "CompanyService.onCompanyAssociationChange should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/company.associationChange.json`);
    json received = boundJsonOf("CompanyService.onCompanyAssociationChange");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testCompanyMergeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("company.merge");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CompanyService.onCompanyMerge"), "CompanyService.onCompanyMerge should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/company.merge.json`);
    json received = boundJsonOf("CompanyService.onCompanyMerge");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testCompanyRestoreDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("company.restore");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CompanyService.onCompanyRestore"), "CompanyService.onCompanyRestore should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/company.restore.json`);
    json received = boundJsonOf("CompanyService.onCompanyRestore");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testContactCreationDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("contact.creation");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ContactService.onContactCreation"), "ContactService.onContactCreation should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/contact.creation.json`);
    json received = boundJsonOf("ContactService.onContactCreation");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testContactDeletionDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("contact.deletion");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ContactService.onContactDeletion"), "ContactService.onContactDeletion should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/contact.deletion.json`);
    json received = boundJsonOf("ContactService.onContactDeletion");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testContactPropertyChangeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("contact.propertyChange");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ContactService.onContactPropertyChange"), "ContactService.onContactPropertyChange should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/contact.propertyChange.json`);
    json received = boundJsonOf("ContactService.onContactPropertyChange");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testContactAssociationChangeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("contact.associationChange");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ContactService.onContactAssociationChange"), "ContactService.onContactAssociationChange should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/contact.associationChange.json`);
    json received = boundJsonOf("ContactService.onContactAssociationChange");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testContactMergeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("contact.merge");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ContactService.onContactMerge"), "ContactService.onContactMerge should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/contact.merge.json`);
    json received = boundJsonOf("ContactService.onContactMerge");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testContactRestoreDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("contact.restore");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ContactService.onContactRestore"), "ContactService.onContactRestore should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/contact.restore.json`);
    json received = boundJsonOf("ContactService.onContactRestore");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testContactPrivacyDeletionDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("contact.privacyDeletion");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ContactService.onContactPrivacyDeletion"), "ContactService.onContactPrivacyDeletion should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/contact.privacyDeletion.json`);
    json received = boundJsonOf("ContactService.onContactPrivacyDeletion");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testConversationCreationDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("conversation.creation");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ConversationService.onConversationCreation"), "ConversationService.onConversationCreation should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/conversation.creation.json`);
    json received = boundJsonOf("ConversationService.onConversationCreation");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testConversationDeletionDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("conversation.deletion");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ConversationService.onConversationDeletion"), "ConversationService.onConversationDeletion should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/conversation.deletion.json`);
    json received = boundJsonOf("ConversationService.onConversationDeletion");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testConversationPropertyChangeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("conversation.propertyChange");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ConversationService.onConversationPropertyChange"), "ConversationService.onConversationPropertyChange should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/conversation.propertyChange.json`);
    json received = boundJsonOf("ConversationService.onConversationPropertyChange");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testConversationPrivacyDeletionDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("conversation.privacyDeletion");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ConversationService.onConversationPrivacyDeletion"), "ConversationService.onConversationPrivacyDeletion should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/conversation.privacyDeletion.json`);
    json received = boundJsonOf("ConversationService.onConversationPrivacyDeletion");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testConversationNewMessageDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("conversation.newMessage");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ConversationService.onConversationNewMessage"), "ConversationService.onConversationNewMessage should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/conversation.newMessage.json`);
    json received = boundJsonOf("ConversationService.onConversationNewMessage");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testDealCreationDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("deal.creation");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("DealService.onDealCreation"), "DealService.onDealCreation should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/deal.creation.json`);
    json received = boundJsonOf("DealService.onDealCreation");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testDealDeletionDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("deal.deletion");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("DealService.onDealDeletion"), "DealService.onDealDeletion should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/deal.deletion.json`);
    json received = boundJsonOf("DealService.onDealDeletion");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testDealPropertyChangeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("deal.propertyChange");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("DealService.onDealPropertyChange"), "DealService.onDealPropertyChange should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/deal.propertyChange.json`);
    json received = boundJsonOf("DealService.onDealPropertyChange");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testDealAssociationChangeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("deal.associationChange");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("DealService.onDealAssociationChange"), "DealService.onDealAssociationChange should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/deal.associationChange.json`);
    json received = boundJsonOf("DealService.onDealAssociationChange");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testDealMergeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("deal.merge");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("DealService.onDealMerge"), "DealService.onDealMerge should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/deal.merge.json`);
    json received = boundJsonOf("DealService.onDealMerge");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testDealRestoreDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("deal.restore");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("DealService.onDealRestore"), "DealService.onDealRestore should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/deal.restore.json`);
    json received = boundJsonOf("DealService.onDealRestore");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testTicketCreationDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("ticket.creation");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("TicketService.onTicketCreation"), "TicketService.onTicketCreation should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/ticket.creation.json`);
    json received = boundJsonOf("TicketService.onTicketCreation");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testTicketDeletionDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("ticket.deletion");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("TicketService.onTicketDeletion"), "TicketService.onTicketDeletion should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/ticket.deletion.json`);
    json received = boundJsonOf("TicketService.onTicketDeletion");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testTicketPropertyChangeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("ticket.propertyChange");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("TicketService.onTicketPropertyChange"), "TicketService.onTicketPropertyChange should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/ticket.propertyChange.json`);
    json received = boundJsonOf("TicketService.onTicketPropertyChange");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testTicketAssociationChangeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("ticket.associationChange");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("TicketService.onTicketAssociationChange"), "TicketService.onTicketAssociationChange should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/ticket.associationChange.json`);
    json received = boundJsonOf("TicketService.onTicketAssociationChange");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testTicketMergeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("ticket.merge");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("TicketService.onTicketMerge"), "TicketService.onTicketMerge should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/ticket.merge.json`);
    json received = boundJsonOf("TicketService.onTicketMerge");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testTicketRestoreDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("ticket.restore");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("TicketService.onTicketRestore"), "TicketService.onTicketRestore should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/ticket.restore.json`);
    json received = boundJsonOf("TicketService.onTicketRestore");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testProductCreationDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("product.creation");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ProductService.onProductCreation"), "ProductService.onProductCreation should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/product.creation.json`);
    json received = boundJsonOf("ProductService.onProductCreation");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testProductDeletionDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("product.deletion");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ProductService.onProductDeletion"), "ProductService.onProductDeletion should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/product.deletion.json`);
    json received = boundJsonOf("ProductService.onProductDeletion");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testProductPropertyChangeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("product.propertyChange");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ProductService.onProductPropertyChange"), "ProductService.onProductPropertyChange should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/product.propertyChange.json`);
    json received = boundJsonOf("ProductService.onProductPropertyChange");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testProductMergeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("product.merge");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ProductService.onProductMerge"), "ProductService.onProductMerge should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/product.merge.json`);
    json received = boundJsonOf("ProductService.onProductMerge");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testProductRestoreDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("product.restore");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ProductService.onProductRestore"), "ProductService.onProductRestore should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/product.restore.json`);
    json received = boundJsonOf("ProductService.onProductRestore");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testLineItemCreationDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("line_item.creation");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("LineItemService.onLineItemCreation"), "LineItemService.onLineItemCreation should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/line_item.creation.json`);
    json received = boundJsonOf("LineItemService.onLineItemCreation");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testLineItemDeletionDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("line_item.deletion");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("LineItemService.onLineItemDeletion"), "LineItemService.onLineItemDeletion should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/line_item.deletion.json`);
    json received = boundJsonOf("LineItemService.onLineItemDeletion");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testLineItemPropertyChangeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("line_item.propertyChange");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("LineItemService.onLineItemPropertyChange"), "LineItemService.onLineItemPropertyChange should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/line_item.propertyChange.json`);
    json received = boundJsonOf("LineItemService.onLineItemPropertyChange");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testLineItemAssociationChangeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("line_item.associationChange");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("LineItemService.onLineItemAssociationChange"), "LineItemService.onLineItemAssociationChange should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/line_item.associationChange.json`);
    json received = boundJsonOf("LineItemService.onLineItemAssociationChange");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testLineItemMergeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("line_item.merge");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("LineItemService.onLineItemMerge"), "LineItemService.onLineItemMerge should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/line_item.merge.json`);
    json received = boundJsonOf("LineItemService.onLineItemMerge");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

@test:Config {}
function testLineItemRestoreDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("line_item.restore");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("LineItemService.onLineItemRestore"), "LineItemService.onLineItemRestore should have fired");
    json fixture = check io:fileReadJson(string `${TRIGGER_PAYLOAD_DIR}/line_item.restore.json`);
    json received = boundJsonOf("LineItemService.onLineItemRestore");
    assertBindsFixture(received, deliveredEvent(received, fixture), "WebhookEvent");
}

