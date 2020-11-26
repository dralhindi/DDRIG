#!/bin/bash

if ! pre-commit --version &> /dev/null
then
    echo "pre-commit is not installed. Please install pre-commit using pip or brew.\n"
    exit
fi

echo "Installing DDRIG dependencies..."

time Rscript -e 'source("./scripts/_install_ddrig_deps.R")'

echo "Installation complete!"
