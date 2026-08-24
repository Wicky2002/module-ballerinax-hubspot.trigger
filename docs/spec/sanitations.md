_Author_:  <!-- TODO: Add author name --> \
_Created_: <!-- TODO: Add date --> \
_Updated_: <!-- TODO: Add date --> \
_Edition_: Swan Lake

# Sanitation for AsyncAPI specification

This document records the sanitation done on top of the AsyncAPI specification for the HubSpot
trigger (`asyncapi.yaml`, this directory). Unlike a client connector, this package is a webhook
*trigger* (an inbound listener) generated from an AsyncAPI spec, not an OpenAPI client spec — the
spec describes the webhook events HubSpot delivers, not a REST API this package calls out to.
These changes are done in order to improve the overall usability, and as workarounds for some
known language limitations.

1. Added an `x-ballerina-auth` block. The spec previously had no webhook signature verification at
   all — any POST claiming to be from HubSpot was dispatched unchecked. HubSpot's real v3 scheme
   was confirmed empirically against a captured live webhook delivery: HMAC-SHA256 of
   `method + callbackUrl + body + timestamp`, base64-encoded, checked against the
   `X-HubSpot-Signature-v3` header, with a 5-minute freshness window against the
   `X-HubSpot-Request-Timestamp` header.
2. Added `x-ballerina-event-identifier.batched: true`. HubSpot delivers multiple events in a
   single POST as a JSON array (up to 100 per request) rather than one event per request — a
   delivery shape the generator had no way to express until this field was added
   (`ballerina-platform/asyncapi-tools#9058`). Without it, the dispatcher would only ever process
   the first event in each batch.
3. Documented (as a comment block in `asyncapi.yaml`) that `callbackUrl` must exactly match
   HubSpot's full external request URI — it's part of the signed payload (`$config('callbackUrl')`
   above), so any mismatch (trailing slash, scheme, path) makes every signature verification fail.

## Ballerina trigger generation

The Ballerina trigger source (`listener.bal`, `dispatcher_service.bal`, `service_types.bal`,
`data_types.bal`) is generated from `asyncapi.yaml` using the `asyncapi-tools` generator
(`ballerina-platform/asyncapi-tools`). The command should be executed from the repository root
directory.

```bash
bal asyncapi http -i docs/spec/asyncapi.yaml -o ballerina/
```

This overwrites `listener.bal`, `dispatcher_service.bal`, `service_types.bal`, and the data-types
file in `ballerina/` with fresh output. Diff the result before committing - anything currently
correct only because of a hand patch to these files (rather than to the spec or the generator
itself) will be silently reverted by this command.
