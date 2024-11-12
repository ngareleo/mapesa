# Mapesa App

Currently runs on Android only.

## Quick start

Boot up your `android` simulator.

If you don't have any M-PESA messages you can load test messages by running the setup android scripts. The script should take less than a minute

```bash
py ./dev/add_sms_messages.py
```

After you've loaded messages, your pretty much set to execute `main.dart`

## Making Model changes

We're using Isar as our local store. You can use [this link](https://isar.dev/schema.html) to checkout the docs. With your understanding of the library, make a change and run the command below at the root of the project to generate the `*.g.dart` files.

```bash
flutter pub run build_runner build
```
