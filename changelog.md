# Changelog
This file contains all the notable changes done to the Ballerina HubSpot trigger through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0]
### Added
- [Services on the trigger listener are listed by `bal build --export-endpoints`](https://github.com/ballerina-platform/ballerina-library/issues/9312), through a compiler plugin packaged with the trigger. Endpoint export needs Ballerina 2201.13.6 or later; on earlier versions the plugin only warns and the build continues.

### Changed
- [Webhook payloads now bind to the concrete event type instead of the `GenericDataType` union](https://github.com/ballerina-platform/ballerina-library/issues/9218). Binding into a union resolved to the first structurally matching member, so the value handed to a handler was typed by declaration order rather than by which event arrived. Each event in a batched delivery is resolved independently, and the type is read from the handler's own parameter at dispatch time, so no event-to-type table is generated. Binding now happens after the delivery is acknowledged, so a payload that does not fit its handler is logged as `DISPATCH_FAILED` instead of failing the request. An event identifier the spec doesn't declare is acknowledged and logged as a `NO_HANDLER_FOR_EVENT` warning instead of returning an error. A declared event whose service type isn't attached is acknowledged and logged as `SERVICE_NOT_ATTACHED` at debug level. Requires `asyncapi.native.handler` 0.6.0.
- [Generated doc comments are wrapped to the 120-character line budget](https://github.com/ballerina-platform/ballerina-library/issues/9217) instead of being emitted as a single long line.
- The listener a trigger creates from a port caps request bodies at 25 MB, as each body is read before its signature is checked ([asyncapi-tools#243](https://github.com/ballerina-platform/asyncapi-tools/pull/243)).
- The trigger's compiler plugin jar is written to `ballerina/lib/` by the `asyncapi` tool and committed with the package, so the repository no longer carries the plugin's source or its build steps ([asyncapi-tools#243](https://github.com/ballerina-platform/asyncapi-tools/pull/243), [asyncapi-tools#260](https://github.com/ballerina-platform/asyncapi-tools/pull/260)).

### Fixed
- The package now includes its `metadata/` folder (trigger metadata and icons). The `Ballerina.toml` template the build writes from was missing `include = ["metadata/**"]`, so builds dropped it.
- `attach` rejects a service that implements two of the trigger's service types, instead of silently dropping the events of the second ([#9425](https://github.com/ballerina-platform/ballerina-library/issues/9425)).
- `detach` keeps the service attached when unmounting its path fails, so the call can be retried ([#9425](https://github.com/ballerina-platform/ballerina-library/issues/9425)).
- `bal build --export-endpoints` reads a port written as a hexadecimal or parenthesized literal, a computed constant, or a constant or listener from another module, and reports an export failure with its cause ([#9425](https://github.com/ballerina-platform/ballerina-library/issues/9425)).

## [0.12.0] - 2026-09-24
### Added
- Initial release of the HubSpot trigger as its own package, migrated out of the `asyncapi-triggers` monorepo (41 events across 7 service types), with HMAC-SHA256 v3 signature verification and batched-event delivery support.
