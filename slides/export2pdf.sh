#!/bin/bash
set -e
cd _site
chmod -R 777 .
date=$(date '+%Y-%m-%dT%H:%M:%S')
for FILE in *.html; do 
    echo "Processing $PWD/$FILE file...";
    filename=$(basename -- "$FILE")
    extension="${filename##*.}"
    filename="${filename%.*}"
    # chrome --headless=new --remote-allow-origins=* --disable-gpu --disable-software-rasterizer --print-to-pdf="$FILE.pdf" "$PWD/$FILE\?print-pdf"
    docker run -v $(pwd):/home/user astefanutti/decktape /home/user/$FILE $filename-$date.pdf
    # Copy the exported PDF from the latest used container to the local file system
    docker cp `docker ps -lq`:slides/$filename-$date.pdf .
done
