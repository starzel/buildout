#!/bin/sh

# This file is meant to be used for running programs as systemd services.
#
# Systemd gives services only a very limited environment. In particular,
# user-specific environment variables, including PATH, are not set. Depending
# on the OS, there may not be much of a userland available at all. NixOS is a
# good example. (Try running /usr/bin/env as a systemd service and look at the
# output in the journal to see what's up on your particular target system.)
#
# Technically, this is because most of the usually available environment comes
# from /etc/profile and $HOME/.profile if these files exist. These are what
# login shells will execute to configure their environment, and interactive
# shells may load even more stuff to assemble the environment that one usually
# uses to run the service programs during development. When systemd runs a
# service, however, there is neither a shell nor a login process involved.
#
# Often, this is dealt with by running wrapper scripts that source the profile
# and then run the service. Rather than creating a wrapper script for each
# service, though, this script executes its first call argument and passes it
# the remaining arguments in turn. This is what the ExecStart value within a
# unit file would look lik:
#
# ExecStart=/path/to/profile.sh /path/to/program arg1 arg2
#
# Note 1: Mind the exec; it's there to replace the shell by the program rather
# than having the shell run as the service with the program being its child.
#
# Note 2: Since we can only rely on /bin/sh as a lowest common denominator and
# there is no reliable way to invoke any possible implementation as a login
# shell from the ExecStart command, we have to source the profile explicitly.

if [ -f /etc/profile ]; then . /etc/profile; fi
if [ -f $HOME/.profile ]; then . $HOME/.profile; fi

exec "$@"
