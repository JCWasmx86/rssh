# rssh

This is a tool that simulates a shell. It it for the case that you have the ability to execute commands
on a remote, but you can't have an interactive shell. (And I used it for exploring Swift)

I implemented this in order to be able to use a nice, interactive/simulated shell with my cloud storage provider ([rsync.net](https://www.rsync.net/))

## Features
- 30 commands that can be executed on the host
- 9 builtin commands that can be used for further processing of the output
- History
- Some readline-goodies like Ctrl+R
- Pipes

## Limitations
- You can't pipe into a command that executes on the host. You can only do this `commandOnHost | builtin1 | builtin2`, not `commandOnHost1 | commandOnHost2`.
- No aliases
- No command chaining using && or ||
- No auto completion.
- No scripts

## Configuration
Create a file `~/.rsshrc` with this contents:
```
connect $USER@$DOMAIN $PATH_TO_PRIVATE_KEY
```

## How does it work?
It works by having all state client side and transforming the entered commands.

Some example transformations:
```
/home/user$ ls foo
# Will be e.g. ls /home/user/foo
/home/user/foo$ stat ~/example.txt
# Will be e.g. stat /home/user/example.txt
```
