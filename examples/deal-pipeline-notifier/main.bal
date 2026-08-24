import ballerina/log;
import ballerinax/trigger.hubspot;

configurable hubspot:ListenerConfig config = {
    webhookSecret: "xxxxxx",
    callbackUrl: "https://xxxxxx.ngrok-free.app"
};

listener hubspot:Listener webhookListener = new (config, 8090);

// Auto-notify on deal creation and stage/property change. DealService declares more remote
// functions than these two - every one of them must still be implemented, even as a no-op,
// since Ballerina requires a complete implementation of the service type.
service hubspot:DealService on webhookListener {

    remote function onDealCreation(hubspot:WebhookEvent payload) returns error? {
        log:printInfo(string `New deal ${payload.objectId ?: 0} created - notify the sales channel`);
    }

    remote function onDealPropertyChange(hubspot:WebhookEvent payload) returns error? {
        if payload.propertyName == "dealstage" {
            log:printInfo(string `Deal ${payload.objectId ?: 0} moved to stage "${payload.propertyValue ?: ""}"`);
        }
    }

    remote function onDealDeletion(hubspot:WebhookEvent payload) returns error? {
        return;
    }

    remote function onDealMerge(hubspot:WebhookEvent payload) returns error? {
        return;
    }

    remote function onDealRestore(hubspot:WebhookEvent payload) returns error? {
        return;
    }

    remote function onDealAssociationChange(hubspot:WebhookEvent payload) returns error? {
        return;
    }
}
