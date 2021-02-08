#!/bin/bash

if [ ! -z "$GITHUB_ACTIONS" ]; then
    cp /.latexmkrc $HOME/
fi

echo "Hello, World!"

latexmk -C main.tex && latexmk main.tex && latexmk -c main.tex

