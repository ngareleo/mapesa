# Mapesa devtools

This is where our developer tools live. For now, we have scripts to interact with the VM such as loading MPESA messages and sending notifications.

## Devtools

As is, the project should be build so you can go ahead and use the tooling. Use `devtools` to access VM capabilities.

### Sending notifications to the VM

```bash
devtools send
```

### Loading the VM with MPESA messages

```bash
devtools init
```

## Making changes

We use [setuptools](https://setuptools.pypa.io/en/latest/userguide/quickstart.html) to provide us CLI capabilities. You can make any changes to the current API. We're using [click](https://click.palletsprojects.com/en/stable/) to build CLI commands. After making changes, you should build the project using the following commands

```bash
pip3 install --editable .
```
