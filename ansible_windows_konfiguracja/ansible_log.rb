2023-01-08 22:29:15,904 p=131890 u=root n=ansible | Using /home/kamil/learn_linux/ansible/ansible.cfg as config file
2023-01-08 22:29:17,568 p=131890 u=root n=ansible | 192.168.1.125 | UNREACHABLE! => {
    "changed": false,
    "msg": "Failed to create temporary directory.In some cases, you may have been able to authenticate and did not have permissions on the target directory. Consider changing the remote tmp path in ansible.cfg to a path rooted in \"/tmp\", for more error information use -vvv. Failed command was: ( umask 77 && mkdir -p \"` echo ~/.ansible/tmp `\"&& mkdir \"` echo ~/.ansible/tmp/ansible-tmp-1673213357.0586908-131892-27542401611610 `\" && echo ansible-tmp-1673213357.0586908-131892-27542401611610=\"` echo ~/.ansible/tmp/ansible-tmp-1673213357.0586908-131892-27542401611610 `\" ), exited with result 1",
    "unreachable": true
}
