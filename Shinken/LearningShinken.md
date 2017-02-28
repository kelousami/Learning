## Terminology & key words

- `discovery`
- `pollers`
- `brokers`
- `receivers`
- `notifications`
- `reactionners`
- `schedulers`
- `arbiters`
- `commands`
- `groups`
- `certs`
- `templates`

## Architecture


## Install

### Requirements

#### Mandatory
- `Python 2.6` or higher.
- `python-pycurl` Python package for Shinken daemon communication.
- `setuptools`

#### Optional
- `Python 2.7` for developers to run test suite _shinken/test/_.
- `python-cherrypy3` enhanced daemons communications, especially in _HTTPS_
  mode.
- `Monitoring plugins` set of plugins to monitor hosts.

### Steps (on redhat/centos)

## Configure

## Run 


## Shinken filesystem structure
- _ETC=`/etc/shinken/`_ location of all configuration files
- _VAR=`/var/lib/shinken`_ location of some variables files (other than _logs_)
- _BIN=`/usr/bin`_ where the launch scripts reside
- _RUN=`/var/run/shinken`_ location of _PID_ files
- _LOG=`/var/log/shinken`_ location of _LOG_ files


