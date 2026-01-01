#!/bin/bash
find . -type f | grep -v [.]aiignore | grep -v [.]git$  | grep -v [.]gitignorefolder | grep -v [.]gitkeep | grep -v [.]gitignore > file.index
