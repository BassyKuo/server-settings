# Server Setting Scripts

## Usage:

1. Install system packages and set configures:

* Ubuntu (x64)

    ```sh
    $ ./setup-apt_x64.sh
    ```

* CentOS (x64)

    ```sh
    $ ./setup-yum_x64.sh
    ```


2. Personal setting:

* Linux Users (x64)

    ```sh
    $ ./user-setup_linux.sh
    ```


* Mac OSX Users (x64)

    ```sh
    $ ./user-setup_macos.sh
    ```


3. Other setups:

    ```sh
    $ cd setup/
    ```


## setup-ml
You can setup ML packages through the scripts.

* Tensorflow (r1.4)

    ```sh
    $ cd setup-ml
    $ bash tensorflow_1.4.0-setup.sh
    ```


* Caffe

    ```sh
    $ cd setup-ml
    $ bash caffe-setup.sh
    ```

