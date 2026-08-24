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
        log:printInfo(string `Company ${payload.objectId ?: 0} created`);
    }

    remote function onCompanyDeletion(hubspot:WebhookEvent payload) returns error? {
        log:printInfo(string `Company ${payload.objectId ?: 0} deleted`);
    }

    remote function onCompanyPropertyChange(hubspot:WebhookEvent payload) returns error? {
        log:printInfo(string `Company ${payload.objectId ?: 0} property "${payload.propertyName ?: ""}" changed to "${payload.propertyValue ?: ""}"`);
    }

    remote function onCompanyAssociationChange(hubspot:WebhookEvent payload) returns error? {
        log:printInfo(string `Company ${payload.objectId ?: 0} association changed`);
    }

    remote function onCompanyMerge(hubspot:WebhookEvent payload) returns error? {
        log:printInfo(string `Company ${payload.objectId ?: 0} merged`);
    }

    remote function onCompanyRestore(hubspot:WebhookEvent payload) returns error? {
        log:printInfo(string `Company ${payload.objectId ?: 0} restored`);
    }
}
