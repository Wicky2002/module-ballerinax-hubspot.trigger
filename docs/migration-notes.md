# Migration notes: full regeneration from spec (breaking)

This release replaces the hand-maintained `ballerina/` source (`data_types.bal`,
`dispatcher_service.bal`, `listener.bal`, `service_types.bal`, `tests/`) with output freshly
generated from `docs/spec/asyncapi.yaml` using the `asyncapi-tools` generator, after fixing two
real gaps in the spec (see `docs/spec/sanitations.md`): no webhook signature verification at all,
and no support for HubSpot's batched event delivery.

## Breaking change: remote function name casing

15 of the connector's 39 remote functions change casing, from a lowercase-suffix form to properly
cased camelCase, e.g. `onCompanyPropertychange` becomes `onCompanyPropertyChange`. This isn't a
new naming choice — it's what the spec's event identifiers always implied; the previous casing was
only still shipping because the generated code was never refreshed against a generator fix. The
same class of rename `module-ballerinax-github.trigger` already went through.

**Full old -> new mapping** (15 renamed, out of 39 total remote functions across 7 service types;
the other 24 had no casing issue and are unchanged):

- `onCompanyAssociationchange` -> `onCompanyAssociationChange`
- `onCompanyPropertychange` -> `onCompanyPropertyChange`
- `onContactAssociationchange` -> `onContactAssociationChange`
- `onContactPrivacydeletion` -> `onContactPrivacyDeletion`
- `onContactPropertychange` -> `onContactPropertyChange`
- `onConversationNewmessage` -> `onConversationNewMessage`
- `onConversationPrivacydeletion` -> `onConversationPrivacyDeletion`
- `onConversationPropertychange` -> `onConversationPropertyChange`
- `onDealAssociationchange` -> `onDealAssociationChange`
- `onDealPropertychange` -> `onDealPropertyChange`
- `onLineItemAssociationchange` -> `onLineItemAssociationChange`
- `onLineItemPropertychange` -> `onLineItemPropertyChange`
- `onProductPropertychange` -> `onProductPropertyChange`
- `onTicketAssociationchange` -> `onTicketAssociationChange`
- `onTicketPropertychange` -> `onTicketPropertyChange`

## New behavior: signature verification is now real

Previously, `dispatcher_service.bal` had no signature check at all — this was silently insecure.
Every webhook request is now verified against HubSpot's real v3 signature scheme before dispatch;
requests that fail verification or the 5-minute freshness window are rejected. See
`docs/spec/sanitations.md` for the exact scheme.

## New behavior: batched deliveries are now handled

HubSpot sends up to 100 events per POST as a JSON array. The dispatcher now iterates the full
batch instead of only ever acting on the first event in each request.
