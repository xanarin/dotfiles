import subprocess

def mailpasswd(account):
    path = "/home/will/.offlineimap/%s_pass.asc" % account
    return subprocess.check_output(["gpg", "--quiet", "--batch", "-d", path]).strip()
