#!/usr/bin/env python3
import tempfile
import urllib.request
import sys
import subprocess

def main():
    temp_path = tempfile.mktemp()
    response = urllib.request.urlopen(sys.argv[1])
    with open(temp_path, "wb") as output_file:
        output_file.write(response.read())
    subprocess.call(["mimeo", temp_path])

if __name__ == "__main__":
    main()
