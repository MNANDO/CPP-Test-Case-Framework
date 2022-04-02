#!/bin/bash

# Generate a list of all of the c++ files in the src folder
temp=`mktemp`

cd src
ls -R *.cpp > $temp
cd ..

LINES=$(cat $temp)
files=""
for LINE in $LINES
do
    files+="src/$LINE "
done

# update libraries and src files 
sed -i -e '/add_executable/d' CMakeLists.txt
echo "add_executable(proj $files)" >> CMakeLists.txt
rm -rf CMakeLists.txt-e

cd build
make
if [ $? -ne 0 ];
then
    echo "************************************"
    echo "****  Your Program Did Not Compile  ****"
    echo "************************************"
    exit 1
fi

echo "SUCCESS: Program compiled!"
cd ..

exit 0
