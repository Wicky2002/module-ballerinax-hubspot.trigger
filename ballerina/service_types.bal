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

# Attachable service type exposing the TicketService family of webhook events.
public type TicketService service object {
    # Triggered on Ticket property change.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onTicketPropertyChange(WebhookEvent payload) returns error?;
    # Triggered on Ticket deletion.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onTicketDeletion(WebhookEvent payload) returns error?;
    # Triggered on Ticket creation.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onTicketCreation(WebhookEvent payload) returns error?;
    # Triggered on Ticket merge.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onTicketMerge(WebhookEvent payload) returns error?;
    # Triggered on Ticket restore.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onTicketRestore(WebhookEvent payload) returns error?;
    # Triggered on Ticket association change.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onTicketAssociationChange(WebhookEvent payload) returns error?;
};

# Attachable service type exposing the CompanyService family of webhook events.
public type CompanyService service object {
    # Triggered on Company deletion.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onCompanyDeletion(WebhookEvent payload) returns error?;
    # Triggered on Company restore.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onCompanyRestore(WebhookEvent payload) returns error?;
    # Triggered on Company merge.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onCompanyMerge(WebhookEvent payload) returns error?;
    # Triggered on Company property change.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onCompanyPropertyChange(WebhookEvent payload) returns error?;
    # Triggered on Company creation.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onCompanyCreation(WebhookEvent payload) returns error?;
    # Triggered on Company association change.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onCompanyAssociationChange(WebhookEvent payload) returns error?;
};

# Attachable service type exposing the LineItemService family of webhook events.
public type LineItemService service object {
    # Triggered on Line item merge.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onLineItemMerge(WebhookEvent payload) returns error?;
    # Triggered on Line item deletion.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onLineItemDeletion(WebhookEvent payload) returns error?;
    # Triggered on Line item property change.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onLineItemPropertyChange(WebhookEvent payload) returns error?;
    # Triggered on Line item restore.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onLineItemRestore(WebhookEvent payload) returns error?;
    # Triggered on Line item association change.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onLineItemAssociationChange(WebhookEvent payload) returns error?;
    # Triggered on Line item creation.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onLineItemCreation(WebhookEvent payload) returns error?;
};

# Attachable service type exposing the ProductService family of webhook events.
public type ProductService service object {
    # Triggered on Product property change.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onProductPropertyChange(WebhookEvent payload) returns error?;
    # Triggered on Product deletion.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onProductDeletion(WebhookEvent payload) returns error?;
    # Triggered on Product merge.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onProductMerge(WebhookEvent payload) returns error?;
    # Triggered on Product restore.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onProductRestore(WebhookEvent payload) returns error?;
    # Triggered on Product creation.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onProductCreation(WebhookEvent payload) returns error?;
};

# Attachable service type exposing the ConversationService family of webhook events.
public type ConversationService service object {
    # Triggered on Conversation creation.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onConversationCreation(WebhookEvent payload) returns error?;
    # Triggered on Conversation property change.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onConversationPropertyChange(WebhookEvent payload) returns error?;
    # Triggered on Conversation privacy deletion.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onConversationPrivacyDeletion(WebhookEvent payload) returns error?;
    # Triggered on Conversation new message.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onConversationNewMessage(WebhookEvent payload) returns error?;
    # Triggered on Conversation deletion.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onConversationDeletion(WebhookEvent payload) returns error?;
};

# Attachable service type exposing the DealService family of webhook events.
public type DealService service object {
    # Triggered on Deal deletion.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onDealDeletion(WebhookEvent payload) returns error?;
    # Triggered on Deal creation.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onDealCreation(WebhookEvent payload) returns error?;
    # Triggered on Deal merge.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onDealMerge(WebhookEvent payload) returns error?;
    # Triggered on Deal property change.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onDealPropertyChange(WebhookEvent payload) returns error?;
    # Triggered on Deal restore.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onDealRestore(WebhookEvent payload) returns error?;
    # Triggered on Deal association change.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onDealAssociationChange(WebhookEvent payload) returns error?;
};

# Attachable service type exposing the ContactService family of webhook events.
public type ContactService service object {
    # Triggered on Contact creation.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onContactCreation(WebhookEvent payload) returns error?;
    # Triggered on Contact association change.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onContactAssociationChange(WebhookEvent payload) returns error?;
    # Triggered on Contact deletion.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onContactDeletion(WebhookEvent payload) returns error?;
    # Triggered on Contact privacy deletion.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onContactPrivacyDeletion(WebhookEvent payload) returns error?;
    # Triggered on Contact property change.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onContactPropertyChange(WebhookEvent payload) returns error?;
    # Triggered on Contact merge.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onContactMerge(WebhookEvent payload) returns error?;
    # Triggered on Contact restore.
    # + payload - the WebhookEvent webhook payload
    # + return - an error if handling the event fails
    remote function onContactRestore(WebhookEvent payload) returns error?;
};

# The union of every service type that can be attached to this listener.
public type GenericServiceType TicketService|CompanyService|LineItemService|ProductService|ConversationService|DealService|ContactService;

