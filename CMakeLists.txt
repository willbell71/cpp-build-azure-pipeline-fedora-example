# Set up CMake

cmake_minimum_required(VERSION 3.17)
project(Main VERSION 1.0.1)

# Configure compiler

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# CTest

include(CTest)
enable_testing()

# Doxygen target

find_package(Doxygen)
set(DOXYGEN_OUTPUT_DIRECTORY ../docs)
doxygen_add_docs(docs ./src)

# Define main build target

add_executable(main
	src/main.cpp)

# CPack

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)
