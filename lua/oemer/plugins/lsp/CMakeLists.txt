cmake_minimum_required(VERSION 3.10)
project(MyProject)

# Force GCC as the compiler
set(CMAKE_C_COMPILER gcc)
set(CMAKE_CXX_COMPILER g++)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Your source files
set(SOURCES
    main.cpp
    # Add other source files here
)

add_executable(${PROJECT_NAME} ${SOURCES})

# Optionally, set the C++ standard
set_target_properties(${PROJECT_NAME} PROPERTIES CXX_STANDARD 17)

