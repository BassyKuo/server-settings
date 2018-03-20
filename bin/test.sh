#!/bin/sh

name=$(who -m | awk '{print $1;}')

echo $name
