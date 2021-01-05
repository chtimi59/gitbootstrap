# git bootstrap

`'bootstrap.sh'` is nothing more than a script to make a `'git clone'` to `'/opt'` folder

```bash
curl -s https://raw.githubusercontent.com/chtimi59/gitbootstrap/master/bootstrap.sh | \
    bash -s <repo_name> [ssh_keypath]
```

If `ssh_keypath` is provided, then a symlink is created such as:

```bash
drwx------ root root /opt/<repo_name>/.ssh/
lrwxrwxrwx root root /opt/<repo_name>/.ssh/github -> $ssh_keypath
```