# Conversation inbox alert

A different domain from the other two examples: alerts on new support-inbox messages instead of
CRM record changes. Good starting point for routing unanswered chats to an on-call channel.

## Run

```bash
bal run
```

Then follow the [Setup guide](../../ballerina/README.md#setup-guide) in the package README to
expose this listener and subscribe your app's webhook to `conversation.newMessage`.
