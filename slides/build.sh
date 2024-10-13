#!/bin/bash
set -exo
quarto render --to revealjs
# quarto preview cs-smartirrigation-full.md --to revealjs --port 6778 --host 0.0.0.0