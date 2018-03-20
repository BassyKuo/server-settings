#!/bin/bash

pip install --upgrade tensorflow-gpu
grep cuda $HOME/.bashrc &> /dev/null
if [ $? -ne 0 ]; then
	echo '# added cuda path'								>> $HOME/.bashrc
	echo 'export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}'	>> $HOME/.bashrc
	echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}'	>> $HOME/.bashrc
fi

# If failed to launch GPU, please contact Administrator to execute: 
#sudo ldconfig /usr/local/cuda/lib64		# check the dynamic link file version
#cd /usr/local/cuda/lib64
#sudo ln -s libcudnn.so.6.* libcudnn.so.5	# link dynamic linker(ilbcudnn.so.6.x) to the file tensorflow needs (libcudnn.so.5)

# Test GPU
python tensorflow-gpu-checking.py 
