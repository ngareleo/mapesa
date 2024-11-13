# Mapesa App

Currently runs on Android only.

## Quick start

Boot up your `android` simulator.

If you don't have any MPESA messages you can use our **devtools** in the `./devtools` directory.
It has different tooling to interact with the VM to make your DX easier. Take a look at the instructions in the `readme`. After you've loaded messages, you're pretty much set to execute `main.dart`

## Making Model changes

We're using [**Isar**](https://isar.dev/schema.html) as our local store. Read through the docs. With your understanding of the library, and start making changes. Run the command below at the root(/) of the project to generate the `*.g.dart` files.

```bash
flutter pub run build_runner build
```
