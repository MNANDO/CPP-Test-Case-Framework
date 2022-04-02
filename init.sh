#!/bin/bash

# Inialize the project folder and initial files 

read -p "Enter the name of this project (Camel cased with first letter capitalized): " proj

# Check if the format of the name is correct 
#   - The first character of the name should be capital
#   - Should not contain alphanumerical characters 
valid=0
while [ $valid -ne 1 ]
do
    # Handle non alphanumerical characters
    if [[ $proj =~ [^[:alnum:]]+ ]]
    then
        echo "Please only include alpha numerical characters in the project name"
        read -p "Enter the name of this project (Camel cased with first letter capitalized): " proj
        continue
    fi
    # Handle incorrect capitalization
    firstChar=${proj:0:1}
    idealChar=$(echo $firstChar | tr [:lower:] [:upper:])
    if [[ $firstChar != $idealChar ]]
    then
        echo "Please capitalize the first character of the project name."
        read -p "Enter the name of this project (Camel cased with first letter capitalized): " proj
        continue
    fi
    valid=1
done

echo "Creating Project..."

# Create the project directory and sub directories and initialize files
mkdir $proj
cd $proj

proj=$(echo $proj | tr [:upper:] [:lower:])

echo "Initializing directories..."
mkdir src lib debug include build

echo "Initializing main.cpp..."
touch src/main.cpp

echo "Initializing CMakeLists.txt..."
touch CMakeLists.txt
echo "cmake_minimum_required(VERSION 3.13)" > CMakeLists.txt
echo "project($proj VERSION 1.0)" >> CMakeLists.txt
echo "set(CMAKE_CXX_STANDARD 14)" >> CMakeLists.txt
echo "set(CMAKE_CXX_STANDARD_REQUIRED ON)" >> CMakeLists.txt
echo "add_executable(proj src/main.cpp)" >> CMakeLists.txt

cd build
cmake ../
cd ..

echo "Initialization Complete"

exit 0
