# Mapesa devtools

This is where our developer tools live. For now, we have scripts to interact with the VM such as loading MPESA messages and sending notifications.

## Devtools

Follow the setup steps then use `devtools` to access VM capabilities.

## Quick Start

To setup devtools you require `python` version 3 and `pip`. After installing python, create a [**virtual environment**](https://realpython.com/python-virtual-environments-a-primer/), activate it, install [**build**](https://build.pypa.io/en/stable/) into your virtualenv and run build to setup scripts. The command below does all the 4 steps. 

```bash
python3 -m venv .venv && source .venv/bin/activate && pip install --upgrade build && python3 -m build
```

After `build` has finished setting up, we need to build the scripts to be able to run `devtools` in the CLI.

```bash
pip3 install --editable .
```

After the build completes, you should be set 🚀

## Using devtools

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
