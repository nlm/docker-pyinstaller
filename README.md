docker-pyinstaller
==========

Docker image for pyinstaller, a static binary packager for python scripts
More informations on [pyinstaller official website](http://www.pyinstaller.org/)

How to use
----------

Build the image (if you did not pull it from docker hub)

    # docker build -t pyinstaller .

Create a directory for your script. In this example, we will use `./data`.

    mkdir data

Put your python script in the data directory

    cat <<EOF >data/hello.py
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

If your script requires additional packages, just add `requirements.txt` file containing
all the packages you need. They will be installed prior to the build.

Customizing the build
---------------------

You can customize the python and pyinstaller versions that you use by defining
the `PYTHON_VERSION` and `PYINSTALLER_VERSION` build args.

Example:

    # docker build -t pyinstaller --build-arg PYTHON_VERSION=2.7 .

