#!/usr/bin/env python3
import sys
import subprocess

def main():
    input_url = sys.argv[1]
    if input_url[-1] == ".":
        input_url = input_url[:-1]
    if input_url[-1] == ")":
        input_url = input_url[:-1]
    subprocess.call(["mimeo", input_url])

if __name__ == "__main__":
    main()
