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
# login shells will source to configure their environment, and interactive
# shells may load even more stuff to assemble the working environment that
# service programs are probably tested in during development. When systemd
# runs a service, though, there is no login shell involved to begin with.
#
# Note: When running a user service, the user's environment might already be
# sourced; it's not clear to me at the time of writing whether this is
# guaranteed behaviour. If you're sure that systemd on your target system
# loads the user environment, you may edit the service unit templates to start
# processes directly rather than using run.sh. Let's assume for now, however,
# that we'd better take care of it.
#
# The obvious solution is to run the service as the command passed to a login
# shell. Most shells offer a command-line option such as -l to make them
# behave like a login shell, but AFAIK this is not required by POSIX. If you
# know how to invoke your target system's shell as a login shell, feel free to
# edit the unit files to do so rather than using ``run.sh``.
#
# In general, however, we don't make any assumptions about what system this
# buildout configuration will be used on. Therefore we can only rely on
# /bin/sh as a lowest common denominator, and there being no reliable way to
# invoke any possible implementation of it as a login shell from the ExecStart
# command, we're left having to source the profile explicitly using a wrapper
# script.
#
# To avoid creating a wrapper script for each service, though, this script
# executes its first call argument and passes it the remaining arguments in
# turn. This is what the ExecStart value within a unit file would look like:
#
# ExecStart=/path/to/profile.sh /path/to/program arg1 arg2
#
# Note: Mind the exec; it's there to replace the shell by the program rather
# than having the shell run as the service with the program being its child.

if [ -f /etc/profile ]; then . /etc/profile; fi
if [ -f $HOME/.profile ]; then . $HOME/.profile; fi

exec "$@"
