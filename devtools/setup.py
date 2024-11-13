from setuptools import setup

setup(
    name="devtools",
    version="0.1.0",
    py_modules=["devtools", "telnetlib"],
    install_requires=["Click"],
    entry_points={
        "console_scripts": [
            "devtools = devtools:devtools"
        ]
    }
)