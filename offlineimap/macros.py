import subprocess

def mailpasswd(account):
    return subprocess.check_output(["pass", "OfflineIMAP/{}".format(account)]).strip()
