## Overview

The [Ballerina](https://ballerina.io/) listener for Hubspot allows you to listen to the following events in a HubSpot account, grouped by the CRM object they relate to.

* **Company** (`CompanyService`): `onCompanyCreation`, `onCompanyDeletion`, `onCompanyPropertyChange`, `onCompanyAssociationChange`, `onCompanyMerge`, `onCompanyRestore`
* **Contact** (`ContactService`): `onContactCreation`, `onContactDeletion`, `onContactPropertyChange`, `onContactAssociationChange`, `onContactMerge`, `onContactRestore`, `onContactPrivacyDeletion`
* **Conversation** (`ConversationService`): `onConversationCreation`, `onConversationDeletion`, `onConversationPropertyChange`, `onConversationPrivacyDeletion`, `onConversationNewMessage`
* **Deal** (`DealService`): `onDealCreation`, `onDealDeletion`, `onDealPropertyChange`, `onDealAssociationChange`, `onDealMerge`, `onDealRestore`
* **Ticket** (`TicketService`): `onTicketCreation`, `onTicketDeletion`, `onTicketPropertyChange`, `onTicketAssociationChange`, `onTicketMerge`, `onTicketRestore`
* **Product** (`ProductService`): `onProductCreation`, `onProductDeletion`, `onProductPropertyChange`, `onProductMerge`, `onProductRestore`
* **Line item** (`LineItemService`): `onLineItemCreation`, `onLineItemDeletion`, `onLineItemPropertyChange`, `onLineItemAssociationChange`, `onLineItemMerge`, `onLineItemRestore`

This module receives HubSpot's webhook events directly, batched into a single delivery when
multiple events occur close together - it does not call HubSpot's own REST API on your behalf.

## Setup guide

Before using this connector in your Ballerina application, you need a HubSpot developer account
and app, and a Ballerina service that HubSpot can reach over the internet to deliver webhook
payloads to. The steps below cover a quick local test setup; see
[Production / business integration](#production--business-integration) for deploying for real use.

### Step 1: Create a HubSpot Developer Account

[Sign up for a HubSpot developer account](https://app.hubspot.com/signup-hubspot/) if you don't already have one.

### Step 2: Install the HubSpot CLI

Install the HubSpot CLI (v7.6.0 or later) using npm:

```sh
npm install -g @hubspot/cli@latest
```

Authenticate the CLI with your developer account:

```sh
hs account auth
```

This opens a browser window. Log in and follow the prompts to link the CLI to your developer account.

### Step 3: Create a Developer Test Account

A developer test account is an isolated HubSpot CRM account used for testing. It is separate from your developer account.

1. In your developer account portal, navigate to **Testing → Developer test accounts**.
2. Click **Create developer test account** and follow the prompts.

<img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.trigger/main/docs/setup/resources/create-dev-account.png alt="Create developer test account" width="70%">

### Step 4: Set Up ngrok

The Ballerina listener runs locally and needs a publicly accessible URL so HubSpot can deliver webhook events to it. [ngrok](https://ngrok.com/) creates a secure tunnel from a public URL to your local service.

Install ngrok and start a tunnel on port `8090` (the default port for the Ballerina listener):

```sh
ngrok http 8090
```

Copy the HTTPS forwarding URL from the ngrok terminal output. It looks like:

```text
https://xxxx-xxx-xxx-xxx.ngrok-free.app
```

> **Save this value** — you will need the ngrok URL when configuring the webhook in Step 6 and in the Quickstart section.

### Step 5: Create a HubSpot Developer Platform App

1. Create a new project using the HubSpot CLI:

    ```sh
    hs project create
    ```

    When prompted:
    - **Base contents** → select `App`
    - **Distribution** → select `private`
    - **Auth** → select `oauth`
    - **Features** → select `Webhooks` (press spacebar to select, enter to confirm)
    - **Name** → enter a name for your project (e.g. `hubspot-webhook-app`)

2. Replace the contents of `src/app/app-hsmeta.json` with the following, adjusting the `uid`, `name`, and `requiredScopes` as needed:

    ```json
    {
      "uid": "hubspot_webhook_app",
      "type": "app",
      "config": {
        "name": "hubspot-webhook-app",
        "distribution": "private",
        "auth": {
          "type": "oauth",
          "redirectUrls": ["http://localhost:3000/oauth-callback"],
          "requiredScopes": [
            "oauth",
            "crm.objects.contacts.read",
            "crm.objects.companies.read",
            "crm.objects.deals.read",
            "tickets",
            "e-commerce",
            "conversations.read"
          ],
          "optionalScopes": [],
          "conditionallyRequiredScopes": []
        },
        "permittedUrls": {
          "fetch": ["https://api.hubapi.com"],
          "iframe": [],
          "img": []
        },
        "support": {
          "supportEmail": "support@example.com",
          "documentationUrl": "https://example.com/docs",
          "supportUrl": "https://example.com/support",
          "supportPhone": "+18005555555"
        }
      }
    }
    ```

    The `requiredScopes` above is the full set covering every object this listener supports. **Cherry-pick only the scopes for the objects you intend to subscribe to** — each object's events require its corresponding scope:

    | Object | Required scope(s) |
    |--------|-------------------|
    | Contact | `crm.objects.contacts.read`|
    | Company | `crm.objects.companies.read` |
    | Deal | `crm.objects.deals.read` |
    | Ticket | `tickets` |
    | Product / Line item | `e-commerce` |
    | Conversation | `conversations.read` |

### Step 6: Configure Webhook Subscriptions

Replace the contents of `src/app/webhooks/webhook-hsmeta.json` with the following. Replace `<YOUR_NGROK_URL>` with the ngrok URL you copied in Step 4.

```json
{
  "uid": "hubspot_webhook_subscriptions",
  "type": "webhooks",
  "config": {
    "settings": {
      "targetUrl": "<YOUR_NGROK_URL>",
      "maxConcurrentRequests": 10
    },
    "subscriptions": {
      "legacyCrmObjects": [
        { "subscriptionType": "company.creation", "active": true },
        { "subscriptionType": "company.deletion", "active": true },
        { "subscriptionType": "company.propertyChange", "propertyName": "name", "active": true },
        { "subscriptionType": "company.associationChange", "active": true },
        { "subscriptionType": "company.merge", "active": true },
        { "subscriptionType": "company.restore", "active": true },

        { "subscriptionType": "contact.creation", "active": true },
        { "subscriptionType": "contact.deletion", "active": true },
        { "subscriptionType": "contact.propertyChange", "propertyName": "email", "active": true },
        { "subscriptionType": "contact.associationChange", "active": true },
        { "subscriptionType": "contact.merge", "active": true },
        { "subscriptionType": "contact.restore", "active": true },

        { "subscriptionType": "deal.creation", "active": true },
        { "subscriptionType": "deal.deletion", "active": true },
        { "subscriptionType": "deal.propertyChange", "propertyName": "dealname", "active": true },
        { "subscriptionType": "deal.associationChange", "active": true },
        { "subscriptionType": "deal.merge", "active": true },
        { "subscriptionType": "deal.restore", "active": true },

        { "subscriptionType": "ticket.creation", "active": true },
        { "subscriptionType": "ticket.deletion", "active": true },
        { "subscriptionType": "ticket.propertyChange", "propertyName": "subject", "active": true },
        { "subscriptionType": "ticket.associationChange", "active": true },
        { "subscriptionType": "ticket.merge", "active": true },
        { "subscriptionType": "ticket.restore", "active": true },

        { "subscriptionType": "product.creation", "active": true },
        { "subscriptionType": "product.deletion", "active": true },
        { "subscriptionType": "product.propertyChange", "propertyName": "name", "active": true },
        { "subscriptionType": "product.merge", "active": true },
        { "subscriptionType": "product.restore", "active": true },

        { "subscriptionType": "line_item.creation", "active": true },
        { "subscriptionType": "line_item.deletion", "active": true },
        { "subscriptionType": "line_item.propertyChange", "propertyName": "quantity", "active": true },
        { "subscriptionType": "line_item.associationChange", "active": true },
        { "subscriptionType": "line_item.merge", "active": true },
        { "subscriptionType": "line_item.restore", "active": true }
      ],
      "hubEvents": [
        { "subscriptionType": "contact.privacyDeletion", "active": true },

        { "subscriptionType": "conversation.creation", "active": true },
        { "subscriptionType": "conversation.deletion", "active": true },
        { "subscriptionType": "conversation.propertyChange", "propertyName": "status", "active": true },
        { "subscriptionType": "conversation.privacyDeletion", "active": true },
        { "subscriptionType": "conversation.newMessage", "active": true }
      ]
    }
  }
}
```

> **Note:** Subscribe only to the events your application needs — each entry above is optional. `propertyChange` subscriptions require a `propertyName`, and you can add one entry per property you want to monitor. `contact.privacyDeletion` and the `conversation.*` events are declared under `hubEvents` rather than `legacyCrmObjects`.

Upload the project to HubSpot:

```sh
hs project upload
```

Wait for both the build and deploy to succeed:

```text
✔ Built hubspot-webhook-app #1
✔ Deployed hubspot-webhook-app #1
```

### Step 7: Retrieve the Client Secret

1. Open the project in the HubSpot portal:

    ```sh
    hs project open
    ```

2. Under **Project Components**, click the UID of your app.
3. Click the **Auth** tab.
4. Under **Client credentials**, copy the **Client Secret**.

<img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.trigger/main/docs/setup/resources/app-auth-tab.png alt="App Client Secret" width="70%">

> **Save this value** — you will need the Client Secret in the Quickstart section when initialising the Ballerina listener. This is the value the listener calls `webhookSecret`.

### Step 8: Install the App in Your Test Account

The app must be installed in a HubSpot account for that account's events to trigger webhooks.

1. Start the OAuth quickstart server in a new terminal. This handles the OAuth token exchange when the browser redirects to `localhost:3000`:

    ```sh
    git clone https://github.com/HubSpot/oauth-quickstart-nodejs.git
    cd oauth-quickstart-nodejs
    npm install
    ```

    Create a `.env` file in the project directory:

    ```dotenv
    CLIENT_ID=<YOUR_CLIENT_ID>
    CLIENT_SECRET=<YOUR_CLIENT_SECRET>
    SCOPES=oauth,crm.objects.contacts.read,crm.objects.contacts.write,crm.objects.companies.read,crm.objects.deals.read,tickets,e-commerce,conversations.read
    ```

    > Keep this `SCOPES` list in sync with the `requiredScopes` you chose in Step 5.

    Start the server:

    ```sh
    npm start
    ```

2. On your app's details page in the developer portal, go to the **Distribution** tab.
3. Click on **Test URL**, under **Sample install URL**.

    <img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.trigger/main/docs/setup/resources/test-install-url.png alt="Test Install URL" width="70%">

4. When prompted, select your **developer test account** as the account to install into.
    <img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.trigger/main/docs/setup/resources/choose-dev-account.png alt="HubSpot OAuth authorization screen showing the test account" width="70%">

5. After authorizing, the browser redirects to `http://localhost:3000`. The page displays an access token and a sample contact name, confirming the installation was successful.

### Production / business integration

The steps above use ngrok's temporary URL and a hardcoded secret, which are fine for local testing
but not for a real deployment. For production use:

1. Deploy your Ballerina service somewhere with a stable, internet-reachable HTTPS URL. Ballerina
   doesn't require any specific hosting platform - containers, a VM, a managed PaaS, or anything
   else that gives you a stable HTTPS endpoint all work equally well.

2. In `src/app/webhooks/webhook-hsmeta.json` (Step 6), set `targetUrl` to your production URL
   instead of the ngrok URL, then re-run `hs project upload`.

3. Rather than hardcoding `webhookSecret` as shown in the Quickstart, inject it via `Config.toml`
   (or your platform's equivalent configuration/secret mechanism), since it's a `configurable`
   value:

   ```toml
   [<your_org>.<your_module_name>.userInput]
   webhookSecret = "<your production Client Secret>"
   callbackUrl = "<your production URL>"
   ```

   `callbackUrl` must exactly match the `targetUrl` you set in step 2 above - it's part of the
   signed payload HubSpot uses to compute the signature, so any mismatch makes verification fail
   for every request.

### Compatibility

|                               | Version                       |
|-------------------------------|-------------------------------|
| Ballerina Language            | Ballerina Swan Lake 2201.13.4 |

## Quickstart

To use the HubSpot listener in your Ballerina application, update the `.bal` file as follows.

Before running the quickstart, ensure you have:
- The **Client Secret** from Step 7 of the Setup guide
- Your **ngrok URL** from Step 4 of the Setup guide
- ngrok running (`ngrok http 8090`)
- The OAuth quickstart server running (`npm start` in the `oauth-quickstart-nodejs` directory)

### Step 1: Import listener

To import the `ballerinax/hubspot.trigger` module into the Ballerina project, add the following statement:

```ballerina
import ballerinax/hubspot.trigger as hubspot;
import ballerina/io;
```

### Step 2: Create a new listener instance

Add the following to your `Config.toml` file, replacing the placeholders with the values saved during the Setup guide:

```toml
webhookSecret = "<YOUR_CLIENT_SECRET>"
callbackUrl = "<YOUR_NGROK_URL>"
```

Then initialise the listener in your `.bal` file:

```ballerina
configurable string webhookSecret = ?;
configurable string callbackUrl = ?;

listener hubspot:Listener hubspotWebhook = new (
    {webhookSecret, callbackUrl},
    8090
);
```

`webhookSecret` and `callbackUrl` should always match the Client Secret and public webhook URL
configured on the HubSpot app - this is what the listener uses to verify incoming payloads
actually came from HubSpot (HubSpot's v3 signature scheme signs the exact callback URL, so it
must match exactly, including scheme, host, path, and query string).

### Step 3: Invoke listener triggers

Now let's use the triggers available within the listener.

For example, you can configure the Ballerina listener to listen to company creation and deletion events as follows:

Listen to HubSpot Company Creation and Deletion

A service attached to one of the listener's service types must implement **all** of that type's remote functions. For example, `CompanyService` exposes six:

```ballerina
service hubspot:CompanyService on hubspotWebhook {
    remote function onCompanyCreation(hubspot:WebhookEvent payload) returns error? {
        io:println(payload);
    }

    remote function onCompanyDeletion(hubspot:WebhookEvent payload) returns error? {
        io:println(payload);
    }

    remote function onCompanyPropertyChange(hubspot:WebhookEvent payload) returns error? {
        io:println(payload);
    }

    remote function onCompanyAssociationChange(hubspot:WebhookEvent payload) returns error? {
        io:println(payload);
    }

    remote function onCompanyMerge(hubspot:WebhookEvent payload) returns error? {
        io:println(payload);
    }

    remote function onCompanyRestore(hubspot:WebhookEvent payload) returns error? {
        io:println(payload);
    }
}
```

**Note:** The event payload does not contain metadata related to the event. You need to use the specific HubSpot client to obtain it.

To compile and run the Ballerina program, issue the following command:

```sh
bal run
```

To verify it is working, go to your **HubSpot test account** and create or delete a Contact, Company, or Deal. You should see the event printed in the Ballerina console output.

<img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.trigger/main/docs/setup/resources/webhook-confirmed.png alt="Ballerina console output showing a real HubSpot webhook event dispatched successfully" width="70%">

## Examples

The `hubspot.trigger` module provides practical examples illustrating usage in various scenarios.
Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-hubspot.trigger/tree/main/examples/),
covering common webhook event handling use cases.

## Report issues

To report bugs, request new features, start new discussions, etc., go to the [Ballerina Library repository](https://github.com/ballerina-platform/ballerina-library)

## Useful links

- For more information go to the [`hubspot.trigger` package](https://central.ballerina.io/ballerinax/hubspot.trigger/latest).
- If you're upgrading from an older version, see the [migration notes](https://github.com/ballerina-platform/module-ballerinax-hubspot.trigger/blob/main/docs/migration-notes.md) for renamed functions and other breaking changes.
- For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
- Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
- Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
