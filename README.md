docker-pyinstaller
==========

Docker image for pyinstaller, a static binary packager for python scripts
More informations on [pyinstaller official website](http://www.pyinstaller.org/)

Basic Usage
-----------

Build the image (if you did not pull it from docker hub)

    # docker build -t pyinstaller .

Create a directory for your script. In this example, we will use `./data`.

    # mkdir data

Put your python script in the data directory

    # cat <<EOF >data/hello.py
    #!/usr/bin/env python
    print("Hello, World!")
    EOF

Run the docker image, binding the data dir to the container's `/data` directory.
This will compile your script.

    # docker run --rm -ti -v $(pwd)/data:/data pyinstaller build --onefile hello.py

The builder does its duty and you will find the result in the `./data/dist` directory.

    # file ./data/dist/hello
    ./data/dist/hello: ELF 64-bit LSB executable, x86-64, version 1 (GNU/Linux), statically linked, stripped
    # ./data/dist/hello
    Hello, World!

Packages Requirements
---------------------

If your script requires additional packages, they must be installed prior to
invoking pyinstaller. There are two ways to achieve this.

### Using the helper

You can create a `.pyinstaller.yml` file at the root of your repo, containing
section describing the packages to install and the commands to run.

The `requirements` section is a list of packages to be installed with `pip`.

    requirements:
      - pyyaml==3.12

The `install` and `build` sections are lists of commands to run to install and
build the binary:

    install:
      - pip install .
    build:
      - pyinstaller --onefile ./hello.spec

Then, start the build using the `autobuild` command:

    # docker run --rm -ti -v $(pwd)/data:/data pyinstaller autobuild

### Using a custom script

You can also write your own script to fit all your needs.

    # cat <<EOF >data/build.sh
    #!/bin/sh
    pip install .
    pyinstaller --onefile ./hello.py
    EOF
    # chmod +x data/build.sh

Then, start the build using the `exec` command:

    # docker run --rm -ti -v $(pwd)/data:/data pyinstaller exec ./build.sh

Customizing the build
---------------------

You can customize the python and pyinstaller versions that you use by defining
the some build args:

- `PYTHON_VERSION`
- `PYINSTALLER_VERSION`

For the helper:

- `PYSCHEMA_VERSION`
- `PYYAML_VERSION`

Example:

    # docker build -t pyinstaller:python2.7 --build-arg PYTHON_VERSION=2.7 .

