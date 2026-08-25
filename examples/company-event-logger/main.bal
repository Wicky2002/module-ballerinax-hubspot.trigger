import ballerina/log;
import ballerinax/trigger.hubspot;

configurable hubspot:ListenerConfig config = {
    webhookSecret: "xxxxxx",
    callbackUrl: "https://xxxxxx.ngrok-free.app"
};

listener hubspot:Listener webhookListener = new (config, 8090);

// The minimal, canonical use case: log every Company lifecycle event.
service hubspot:CompanyService on webhookListener {

    remote function onCompanyCreation(hubspot:WebhookEvent payload) returns error? {
        log:printInfo("Company created", id = payload.objectId ?: 0);
    }

    remote function onCompanyDeletion(hubspot:WebhookEvent payload) returns error? {
        log:printInfo("Company deleted", id = payload.objectId ?: 0);
    }

    remote function onCompanyPropertyChange(hubspot:WebhookEvent payload) returns error? {
        log:printInfo("Company property changed", id = payload.objectId ?: 0,
                property = payload.propertyName ?: "", value = payload.propertyValue ?: "");
    }

    remote function onCompanyAssociationChange(hubspot:WebhookEvent payload) returns error? {
        log:printInfo("Company association changed", id = payload.objectId ?: 0);
    }

    remote function onCompanyMerge(hubspot:WebhookEvent payload) returns error? {
        log:printInfo("Company merged", id = payload.objectId ?: 0);
    }

    remote function onCompanyRestore(hubspot:WebhookEvent payload) returns error? {
        log:printInfo("Company restored", id = payload.objectId ?: 0);
    }
}
