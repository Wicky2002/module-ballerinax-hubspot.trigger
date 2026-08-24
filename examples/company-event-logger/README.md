# Company event logger

The minimal, canonical `trigger.hubspot` use case: listen for every `Company` lifecycle event and
log a one-line summary.

## Run

```bash
bal run
```

Then follow the [Setup guide](../../ballerina/README.md#setup-guide) in the package README to
expose this listener and subscribe your app's webhook to the `company.*` events.
