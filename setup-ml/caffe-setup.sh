#!/bin/bash

sudo yum install -y protobuf-devel leveldb-devel snappy-devel opencv-devel boost-devel hdf5-devel
sudo yum install -y gflags-devel glog-devel lmdb-devel

cd $HOME
test -d caffe/ && rm -r caffe/
git clone https://github.com/BVLC/caffe
cd $HOME/caffe/
cp Makefile.config.example Makefile.config

### Adjust Makefile.config (for example, if using Anaconda Python, or if cuDNN is desired)
### [NOTICE] `openblas` is better than `atlas`, and intel `MKL` is the best 
### ######## <from> https://github.com/tmolteno/necpp/issues/18 
sed -i "s/^\#\s\(CPU_ONLY\s:=.*\)/\1/g" Makefile.config
sed -i "s/^BLAS\s:=\satlas/BLAS := open/g" Makefile.config
sed -i "s/^\#\sBLAS_INCLUDE\s:=\s\/.*/BLAS_INCLUDE := \/usr\/include\/openblas/g" Makefile.config
sed -i "s#\(/usr\)/lib/\(python2.7/dist-packages/numpy/core/include\)#\1/lib64/\2#g" Makefile.config
make all -j4
make test -j4
make runtest -j4
