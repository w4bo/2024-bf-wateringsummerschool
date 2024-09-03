#!/bin/bash
set -exo
# quarto pandoc -o slides.pptx --print-default-data-file reference.pptx 
quarto render --to revealjs
# quarto render --to pptx