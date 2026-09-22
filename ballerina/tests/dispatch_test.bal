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
import ballerina/io;
import ballerina/lang.runtime;
import ballerina/test;
import ballerina/time;

const TRIGGER_TEST_SECRET = "trigger-test-secret";
const TRIGGER_TEST_PORT = 9091;
const TRIGGER_PAYLOAD_DIR = "tests/resources/trigger_payloads";
const TRIGGER_TEST_CALLBACK_URL = "test-callbackUrl-value";

isolated map<boolean> triggerFired = {};

listener Listener triggerTestListener = check new ({webhookSecret: TRIGGER_TEST_SECRET, callbackUrl: TRIGGER_TEST_CALLBACK_URL}, TRIGGER_TEST_PORT);

final http:Client triggerClient = check new (string `http://localhost:${TRIGGER_TEST_PORT}`);

service DealService on triggerTestListener {
    isolated remote function onDealDeletion(WebhookEvent payload) returns error? {
        lock {
            triggerFired["DealService.onDealDeletion"] = true;
        }
    }

    isolated remote function onDealCreation(WebhookEvent payload) returns error? {
        lock {
            triggerFired["DealService.onDealCreation"] = true;
        }
    }

    isolated remote function onDealMerge(WebhookEvent payload) returns error? {
        lock {
            triggerFired["DealService.onDealMerge"] = true;
        }
    }

    isolated remote function onDealPropertyChange(WebhookEvent payload) returns error? {
        lock {
            triggerFired["DealService.onDealPropertyChange"] = true;
        }
    }

    isolated remote function onDealRestore(WebhookEvent payload) returns error? {
        lock {
            triggerFired["DealService.onDealRestore"] = true;
        }
    }

    isolated remote function onDealAssociationChange(WebhookEvent payload) returns error? {
        lock {
            triggerFired["DealService.onDealAssociationChange"] = true;
        }
    }
}

service ProductService on triggerTestListener {
    isolated remote function onProductPropertyChange(WebhookEvent payload) returns error? {
        lock {
            triggerFired["ProductService.onProductPropertyChange"] = true;
        }
    }

    isolated remote function onProductDeletion(WebhookEvent payload) returns error? {
        lock {
            triggerFired["ProductService.onProductDeletion"] = true;
        }
    }

    isolated remote function onProductMerge(WebhookEvent payload) returns error? {
        lock {
            triggerFired["ProductService.onProductMerge"] = true;
        }
    }

    isolated remote function onProductRestore(WebhookEvent payload) returns error? {
        lock {
            triggerFired["ProductService.onProductRestore"] = true;
        }
    }

    isolated remote function onProductCreation(WebhookEvent payload) returns error? {
        lock {
            triggerFired["ProductService.onProductCreation"] = true;
        }
    }
}

service LineItemService on triggerTestListener {
    isolated remote function onLineItemMerge(WebhookEvent payload) returns error? {
        lock {
            triggerFired["LineItemService.onLineItemMerge"] = true;
        }
    }

    isolated remote function onLineItemDeletion(WebhookEvent payload) returns error? {
        lock {
            triggerFired["LineItemService.onLineItemDeletion"] = true;
        }
    }

    isolated remote function onLineItemPropertyChange(WebhookEvent payload) returns error? {
        lock {
            triggerFired["LineItemService.onLineItemPropertyChange"] = true;
        }
    }

    isolated remote function onLineItemRestore(WebhookEvent payload) returns error? {
        lock {
            triggerFired["LineItemService.onLineItemRestore"] = true;
        }
    }

    isolated remote function onLineItemAssociationChange(WebhookEvent payload) returns error? {
        lock {
            triggerFired["LineItemService.onLineItemAssociationChange"] = true;
        }
    }

    isolated remote function onLineItemCreation(WebhookEvent payload) returns error? {
        lock {
            triggerFired["LineItemService.onLineItemCreation"] = true;
        }
    }
}

service TicketService on triggerTestListener {
    isolated remote function onTicketPropertyChange(WebhookEvent payload) returns error? {
        lock {
            triggerFired["TicketService.onTicketPropertyChange"] = true;
        }
    }

    isolated remote function onTicketDeletion(WebhookEvent payload) returns error? {
        lock {
            triggerFired["TicketService.onTicketDeletion"] = true;
        }
    }

    isolated remote function onTicketCreation(WebhookEvent payload) returns error? {
        lock {
            triggerFired["TicketService.onTicketCreation"] = true;
        }
    }

    isolated remote function onTicketMerge(WebhookEvent payload) returns error? {
        lock {
            triggerFired["TicketService.onTicketMerge"] = true;
        }
    }

    isolated remote function onTicketRestore(WebhookEvent payload) returns error? {
        lock {
            triggerFired["TicketService.onTicketRestore"] = true;
        }
    }

    isolated remote function onTicketAssociationChange(WebhookEvent payload) returns error? {
        lock {
            triggerFired["TicketService.onTicketAssociationChange"] = true;
        }
    }
}

service ContactService on triggerTestListener {
    isolated remote function onContactCreation(WebhookEvent payload) returns error? {
        lock {
            triggerFired["ContactService.onContactCreation"] = true;
        }
    }

    isolated remote function onContactAssociationChange(WebhookEvent payload) returns error? {
        lock {
            triggerFired["ContactService.onContactAssociationChange"] = true;
        }
    }

    isolated remote function onContactDeletion(WebhookEvent payload) returns error? {
        lock {
            triggerFired["ContactService.onContactDeletion"] = true;
        }
    }

    isolated remote function onContactPrivacyDeletion(WebhookEvent payload) returns error? {
        lock {
            triggerFired["ContactService.onContactPrivacyDeletion"] = true;
        }
    }

    isolated remote function onContactPropertyChange(WebhookEvent payload) returns error? {
        lock {
            triggerFired["ContactService.onContactPropertyChange"] = true;
        }
    }

    isolated remote function onContactMerge(WebhookEvent payload) returns error? {
        lock {
            triggerFired["ContactService.onContactMerge"] = true;
        }
    }

    isolated remote function onContactRestore(WebhookEvent payload) returns error? {
        lock {
            triggerFired["ContactService.onContactRestore"] = true;
        }
    }
}

service CompanyService on triggerTestListener {
    isolated remote function onCompanyDeletion(WebhookEvent payload) returns error? {
        lock {
            triggerFired["CompanyService.onCompanyDeletion"] = true;
        }
    }

    isolated remote function onCompanyRestore(WebhookEvent payload) returns error? {
        lock {
            triggerFired["CompanyService.onCompanyRestore"] = true;
        }
    }

    isolated remote function onCompanyMerge(WebhookEvent payload) returns error? {
        lock {
            triggerFired["CompanyService.onCompanyMerge"] = true;
        }
    }

    isolated remote function onCompanyPropertyChange(WebhookEvent payload) returns error? {
        lock {
            triggerFired["CompanyService.onCompanyPropertyChange"] = true;
        }
    }

    isolated remote function onCompanyCreation(WebhookEvent payload) returns error? {
        lock {
            triggerFired["CompanyService.onCompanyCreation"] = true;
        }
    }

    isolated remote function onCompanyAssociationChange(WebhookEvent payload) returns error? {
        lock {
            triggerFired["CompanyService.onCompanyAssociationChange"] = true;
        }
    }
}

service ConversationService on triggerTestListener {
    isolated remote function onConversationCreation(WebhookEvent payload) returns error? {
        lock {
            triggerFired["ConversationService.onConversationCreation"] = true;
        }
    }

    isolated remote function onConversationPropertyChange(WebhookEvent payload) returns error? {
        lock {
            triggerFired["ConversationService.onConversationPropertyChange"] = true;
        }
    }

    isolated remote function onConversationPrivacyDeletion(WebhookEvent payload) returns error? {
        lock {
            triggerFired["ConversationService.onConversationPrivacyDeletion"] = true;
        }
    }

    isolated remote function onConversationNewMessage(WebhookEvent payload) returns error? {
        lock {
            triggerFired["ConversationService.onConversationNewMessage"] = true;
        }
    }

    isolated remote function onConversationDeletion(WebhookEvent payload) returns error? {
        lock {
            triggerFired["ConversationService.onConversationDeletion"] = true;
        }
    }
}

isolated function sendSignedTriggerWebhook(string headerValue, string eventIdentifier) returns http:Response|error {
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

@test:Config {}
function testDealDeletionDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("deal.deletion", "deal.deletion");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("DealService.onDealDeletion"), "DealService.onDealDeletion should have fired");
}

@test:Config {}
function testDealCreationDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("deal.creation", "deal.creation");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("DealService.onDealCreation"), "DealService.onDealCreation should have fired");
}

@test:Config {}
function testDealMergeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("deal.merge", "deal.merge");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("DealService.onDealMerge"), "DealService.onDealMerge should have fired");
}

@test:Config {}
function testDealPropertyChangeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("deal.propertyChange", "deal.propertyChange");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("DealService.onDealPropertyChange"), "DealService.onDealPropertyChange should have fired");
}

@test:Config {}
function testDealRestoreDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("deal.restore", "deal.restore");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("DealService.onDealRestore"), "DealService.onDealRestore should have fired");
}

@test:Config {}
function testDealAssociationChangeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("deal.associationChange", "deal.associationChange");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("DealService.onDealAssociationChange"), "DealService.onDealAssociationChange should have fired");
}

@test:Config {}
function testProductPropertyChangeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("product.propertyChange", "product.propertyChange");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ProductService.onProductPropertyChange"), "ProductService.onProductPropertyChange should have fired");
}

@test:Config {}
function testProductDeletionDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("product.deletion", "product.deletion");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ProductService.onProductDeletion"), "ProductService.onProductDeletion should have fired");
}

@test:Config {}
function testProductMergeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("product.merge", "product.merge");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ProductService.onProductMerge"), "ProductService.onProductMerge should have fired");
}

@test:Config {}
function testProductRestoreDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("product.restore", "product.restore");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ProductService.onProductRestore"), "ProductService.onProductRestore should have fired");
}

@test:Config {}
function testProductCreationDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("product.creation", "product.creation");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ProductService.onProductCreation"), "ProductService.onProductCreation should have fired");
}

@test:Config {}
function testLineItemMergeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("line_item.merge", "line_item.merge");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("LineItemService.onLineItemMerge"), "LineItemService.onLineItemMerge should have fired");
}

@test:Config {}
function testLineItemDeletionDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("line_item.deletion", "line_item.deletion");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("LineItemService.onLineItemDeletion"), "LineItemService.onLineItemDeletion should have fired");
}

@test:Config {}
function testLineItemPropertyChangeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("line_item.propertyChange", "line_item.propertyChange");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("LineItemService.onLineItemPropertyChange"), "LineItemService.onLineItemPropertyChange should have fired");
}

@test:Config {}
function testLineItemRestoreDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("line_item.restore", "line_item.restore");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("LineItemService.onLineItemRestore"), "LineItemService.onLineItemRestore should have fired");
}

@test:Config {}
function testLineItemAssociationChangeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("line_item.associationChange", "line_item.associationChange");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("LineItemService.onLineItemAssociationChange"), "LineItemService.onLineItemAssociationChange should have fired");
}

@test:Config {}
function testLineItemCreationDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("line_item.creation", "line_item.creation");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("LineItemService.onLineItemCreation"), "LineItemService.onLineItemCreation should have fired");
}

@test:Config {}
function testTicketPropertyChangeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("ticket.propertyChange", "ticket.propertyChange");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("TicketService.onTicketPropertyChange"), "TicketService.onTicketPropertyChange should have fired");
}

@test:Config {}
function testTicketDeletionDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("ticket.deletion", "ticket.deletion");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("TicketService.onTicketDeletion"), "TicketService.onTicketDeletion should have fired");
}

@test:Config {}
function testTicketCreationDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("ticket.creation", "ticket.creation");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("TicketService.onTicketCreation"), "TicketService.onTicketCreation should have fired");
}

@test:Config {}
function testTicketMergeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("ticket.merge", "ticket.merge");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("TicketService.onTicketMerge"), "TicketService.onTicketMerge should have fired");
}

@test:Config {}
function testTicketRestoreDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("ticket.restore", "ticket.restore");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("TicketService.onTicketRestore"), "TicketService.onTicketRestore should have fired");
}

@test:Config {}
function testTicketAssociationChangeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("ticket.associationChange", "ticket.associationChange");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("TicketService.onTicketAssociationChange"), "TicketService.onTicketAssociationChange should have fired");
}

@test:Config {}
function testContactCreationDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("contact.creation", "contact.creation");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ContactService.onContactCreation"), "ContactService.onContactCreation should have fired");
}

@test:Config {}
function testContactAssociationChangeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("contact.associationChange", "contact.associationChange");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ContactService.onContactAssociationChange"), "ContactService.onContactAssociationChange should have fired");
}

@test:Config {}
function testContactDeletionDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("contact.deletion", "contact.deletion");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ContactService.onContactDeletion"), "ContactService.onContactDeletion should have fired");
}

@test:Config {}
function testContactPrivacyDeletionDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("contact.privacyDeletion", "contact.privacyDeletion");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ContactService.onContactPrivacyDeletion"), "ContactService.onContactPrivacyDeletion should have fired");
}

@test:Config {}
function testContactPropertyChangeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("contact.propertyChange", "contact.propertyChange");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ContactService.onContactPropertyChange"), "ContactService.onContactPropertyChange should have fired");
}

@test:Config {}
function testContactMergeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("contact.merge", "contact.merge");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ContactService.onContactMerge"), "ContactService.onContactMerge should have fired");
}

@test:Config {}
function testContactRestoreDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("contact.restore", "contact.restore");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ContactService.onContactRestore"), "ContactService.onContactRestore should have fired");
}

@test:Config {}
function testCompanyDeletionDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("company.deletion", "company.deletion");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CompanyService.onCompanyDeletion"), "CompanyService.onCompanyDeletion should have fired");
}

@test:Config {}
function testCompanyRestoreDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("company.restore", "company.restore");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CompanyService.onCompanyRestore"), "CompanyService.onCompanyRestore should have fired");
}

@test:Config {}
function testCompanyMergeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("company.merge", "company.merge");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CompanyService.onCompanyMerge"), "CompanyService.onCompanyMerge should have fired");
}

@test:Config {}
function testCompanyPropertyChangeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("company.propertyChange", "company.propertyChange");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CompanyService.onCompanyPropertyChange"), "CompanyService.onCompanyPropertyChange should have fired");
}

@test:Config {}
function testCompanyCreationDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("company.creation", "company.creation");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CompanyService.onCompanyCreation"), "CompanyService.onCompanyCreation should have fired");
}

@test:Config {}
function testCompanyAssociationChangeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("company.associationChange", "company.associationChange");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("CompanyService.onCompanyAssociationChange"), "CompanyService.onCompanyAssociationChange should have fired");
}

@test:Config {}
function testConversationCreationDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("conversation.creation", "conversation.creation");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ConversationService.onConversationCreation"), "ConversationService.onConversationCreation should have fired");
}

@test:Config {}
function testConversationPropertyChangeDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("conversation.propertyChange", "conversation.propertyChange");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ConversationService.onConversationPropertyChange"), "ConversationService.onConversationPropertyChange should have fired");
}

@test:Config {}
function testConversationPrivacyDeletionDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("conversation.privacyDeletion", "conversation.privacyDeletion");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ConversationService.onConversationPrivacyDeletion"), "ConversationService.onConversationPrivacyDeletion should have fired");
}

@test:Config {}
function testConversationNewMessageDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("conversation.newMessage", "conversation.newMessage");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ConversationService.onConversationNewMessage"), "ConversationService.onConversationNewMessage should have fired");
}

@test:Config {}
function testConversationDeletionDispatch() returns error? {
    http:Response response = check sendSignedTriggerWebhook("conversation.deletion", "conversation.deletion");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertTrue(waitForDispatch("ConversationService.onConversationDeletion"), "ConversationService.onConversationDeletion should have fired");
}

