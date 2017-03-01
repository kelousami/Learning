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
See `./resources/shinken-architecture.png`

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

The main configuration file is /etc/shinken/shinken.cfg
It's given to arbiter module as parameter from command line.

The configuration is split to several configuration files, in directories
alonside shinken.cfg. One file for one object definition.

cfg\_dir statement indicates configuration files directory. It only reads .cfg
files.

For daemons (pollers, scheduler, receivers ..etc) their configuration is
specified in .cfg files under specific folders alonside shinkin.cfg. For
example /etc/shinken/pollers/ for poller daemons.

Modules configuration files are in /etc/shinken/modules/.

Modules are loaded by daemons. To load a module, use the statement __modules__.

Resource files are used to store custom macros. Users may use them to store
sensitive configuration information (passwords) without making them available
to programs (CGIs ..). Shenkin daemon (/usr/bin/shinken-arbiter) is responsible
of managing resource files.

resource\_file directive may be used in main configuration file to specify one
or more optional resource files.

Object definition files are used to specify objects/items we want to monitor and how
we should monitor them. Objects/items include hosts, services, hostgroups,
contacts, contactgroups, commands, etc.

Ojbect definition file is specified by cfg\_file and/or cfg\_dir in the main
configuration file.


## Run 

## Shinken filesystem structure
- _ETC=`/etc/shinken/`_ location of all configuration files
- _VAR=`/var/lib/shinken`_ location of some variables files (other than _logs_)
- _BIN=`/usr/bin`_ where the launch scripts reside
- _RUN=`/var/run/shinken`_ location of _PID_ files
- _LOG=`/var/log/shinken`_ location of _LOG_ files


