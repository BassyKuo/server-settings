#!/bin/bash
# refer to https://github.com/mind/wheels#versions
read -p 'Install [C]pu verion or [G]pu version? [C/g] ' ans
if [[ $ans =~ ^[cC]*$ ]]; then
	pip3 install --no-cache-dir https://github.com/mind/wheels/releases/download/tf1.4-cpu/tensorflow-1.4.0-cp36-cp36m-linux_x86_64.whl
else
	pip3 install --no-cache-dir https://github.com/mind/wheels/releases/download/tf1.4-gpu/tensorflow-1.4.0-cp36-cp36m-linux_x86_64.whl
fi
pip3 install numpy --upgrade
python3.6 -c 'import tensorflow as tf; print ("Tensorflow Version:", tf.VERSION)'
