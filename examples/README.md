# Examples

The `ballerinax/hubspot.trigger` connector provides practical examples illustrating usage in various scenarios.

1. [Company event logger](company-event-logger) - the minimal, canonical use case: log every `Company` lifecycle event.
2. [Deal pipeline notifier](deal-pipeline-notifier) - notify on deal creation and stage changes, a starting point for sales-pipeline automation.
3. [Conversation inbox alert](conversation-inbox-alert) - a different domain: alert on new support-inbox messages instead of CRM record changes.

## Prerequisites

Complete the [Setup guide](../ballerina/README.md#setup-guide) in the package README first - each
example needs a HubSpot app with a webhook subscribed to the events it listens for.

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
