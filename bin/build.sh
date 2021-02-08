#!/bin/bash

echo "Hello, World!"

if [ ! -z "$GITHUB_ACTIONS" ]; then
    cp /.latexmkrc $HOME/
fi

latexmk -C main.tex && latexmk main.tex && latexmk -c main.tex

