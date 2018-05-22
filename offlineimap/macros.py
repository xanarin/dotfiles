#!/usr/bin/python2
import subprocess
import os

def mailpasswd(account):
    try:
        passcode = subprocess.check_output(["pass", "OfflineIMAP/{}".format(account)], env=dict(os.environ, DISPLAY=":0.0")).strip()
        return passcode
    except subprocess.CalledProcessError as err:
        raise Exception("Failed to get GPG key with error:\n{}".format(err.output))
