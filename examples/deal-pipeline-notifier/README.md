# Deal pipeline notifier

Notifies on deal creation and stage changes, ignoring the rest of `DealService`'s events. A good
starting point for sales-pipeline automation (e.g. posting to Slack when a deal moves stage).

## Run

```bash
bal run
```

Then follow the [Setup guide](../../ballerina/README.md#setup-guide) in the package README to
expose this listener and subscribe your app's webhook to at least `deal.creation` and
`deal.propertyChange` (with `propertyName: "dealstage"`).
