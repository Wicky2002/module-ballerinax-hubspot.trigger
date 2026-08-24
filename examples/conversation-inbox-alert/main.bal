import ballerina/log;
import ballerinax/trigger.hubspot;

configurable hubspot:ListenerConfig config = {
    webhookSecret: "xxxxxx",
    callbackUrl: "https://xxxxxx.ngrok-free.app"
};

listener hubspot:Listener webhookListener = new (config, 8090);

// A different domain from the other two examples: support inbox messages instead of CRM records.
service hubspot:ConversationService on webhookListener {

    remote function onConversationNewMessage(hubspot:WebhookEvent payload) returns error? {
        log:printWarn(string `New inbox message on conversation thread ${payload.objectId ?: 0} - needs a response`);
    }

    remote function onConversationCreation(hubspot:WebhookEvent payload) returns error? {
        return;
    }

    remote function onConversationPropertyChange(hubspot:WebhookEvent payload) returns error? {
        return;
    }

    remote function onConversationPrivacyDeletion(hubspot:WebhookEvent payload) returns error? {
        return;
    }

    remote function onConversationDeletion(hubspot:WebhookEvent payload) returns error? {
        return;
    }
}
