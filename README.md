# Puppet Nagios management

[![Build Status](https://travis-ci.org/tykeal/puppet-nagios.png)](https://travis-ci.org/tykeal/puppet-nagios)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with nagios](#setup)
    * [What nagios affects](#what-nagios-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with nagios](#beginning-with-nagios)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

You're probably thinking. Another Nagios module? There's so many already. In
this you would be absolutely correct. When this module was first started none of
the modules on the forge met our needs, because of that this was developed and
has been in use for well over a year before it was determined to be time to
bring it to the forge.

## Module Description

The Nagios module relies heavily on exported resource to work its magic. If
you're environment is not using exported resources than this module is not for
you.

Additionally, to leverage a lot of the power of the module, it is expected that
you're using hiera for the APL linkages.

## Setup

### What nagios affects

There are two primary components of the module

First, the server configuration itself. By default the server will fully setup a
host just like a fresh install on any RHEL system. You will have all the default
definitions for all resources created and fully managed.

Second, the client. Clients will have two types of checks added. The first type
is a common default aka 'baseservices' set of checks. The default configuration
is empty and as such nodes will not have any services being checked. This will,
in fact, cause nagios to have issues if there are no checks defined for a node!
The second type of checks are node specific checks.

Finally, there are the checks that you add to the profiles for your various
services. This is where the power starts really showing up as you end up with
just the checks that you actually need attached to your node based completely
upon what is defined on the node.

### Beginning with nagios

To start with let's take a look at a very basic hiera common configuration that
you might use:

```hiera
---

# This module uses a tag for determining what nagios server should pick up
# resorces to monitor. If the server and clients have a tag of '' (default)
# then all essentially untagged resources will be monitored
nagiosserver: 'my-enviornment-monitor'
nagios::nagiostag: "%{hiera('nagiosserver')}"
nagios::client::nagiostag: "%{hiera('nagiosserver')}"

# define the default hostconfig for clients
nagios::client::hostconfig:
  use: 'generic-linux-server'

# define our base client checks (just PING for now)
nagios::client::baseservices:
  "PING-%{::fqdn}":
    resourcedef:
      service_description: 'Ping'
      check_command: 'check_ping!2000.0,80%!2800.0,100%'
```

Now for the server all you would need to do would be a basic profile like the
following. **NOTE** The nagios module does not configure the webserver for
serving the cgi application.

```puppet
class profile::nagios::server {
  include ::nagios
}
```

And for your clients you would want a profile similar to this:

```puppet
class profile::nagios::client {
  include ::nagios::client
}
```

Now assuming that your system roles all include the profile::nagios::client then
any system will get ping monitoring.

## Usage

The power of this module is in that it gives you complete control of what
options are going to get set. Under the hood the module uses the various
nagios_* resources that puppet offers. As such, if it's an option there, it's an
option for you to configure.

For a slightly more complex configuration, let's look at monitoring a Gerrit
system that is using the `tykeal/gerrit` module. A basic profile that adds in
monitoring that the Gerrit SSH port is listening could be done in the following
way:

```puppet
class profile::gerrit {
  include ::gerrit

  # any other configuration you want

  # monitoring configuration
  include ::nagios::params

  $nagios_tag = hiera('nagios::client::nagiostag', '')
  $defaultserviceconfig = hiera('nagios::client::defaultserviceconfig',
    $::nagios::params::defaultserviceconfig)

  # grab the Gerrit overrides which have to be set
  if ( has_key($gerrit_config, 'sshd') ) {
    if ( has_key($gerrit_config['sshd'], 'listenAddress') ) {
      validate_string($gerrit_config['sshd']['listenAddress'])
      $git_port_expr = '^.*:([0-9]{1,5})$'
      $git_port = regsubst($gerrit_config['sshd']['listenAddress'],
        $git_port_expr, '\1', 'EI')
    } else {
      # default port
      $git_port = 29418
    }
  } else {
    # default port
    $git_port = 29418
  }

  # Verify the Gerrit SSH/git service is responding
  # NOTE: This is not testing any reverse proxy configuration!
  ::nagios::resource { "Gerrit-SSH-Status-${::fqdn}":
    # lint:ignore:arrow_alignment
    resource_type         => 'service',
    defaultresourcedef    => $defaultserviceconfig,
    nagiostag             => $nagios_tag,
    resourcedef           => {
    # lint:endignore
      service_description => 'Gerrit SSH - git Status',
      check_command       => "check_ssh!-t 30 -p ${git_port}",
    },
  }
}
```

With this, admittedly not simple, change any system that gets this profile
attached to it will also start to automatically monitor the defined Gerrit SSH
service.

With this and an NRPE module such as `pdxcat/nrpe` you're now set to get your
monitoring on.

## Reference

This module takes a lot of parameters. While I hate to suggest you go read the
code the parameters are fully documented in the header of each of the classes
and defines. For reference here are the top level classes and defines that
you're expected to use:

`class nagios` (see init.pp) - no required parameters
`class nagios::client` (see client.pp) - no required parameters
`define nagios::resource` (see resource.pp) - the following parameter is
required: `resource_type` which is one of the defined resource types that nagios
supports.

For more complex setup scenarios see the following repositories:

[Tykeal's Testing Hiera](https://github.com/tykeal/puppetserver-hiera)
[Tykeal's Master repo](https://github.com/tykeal/puppetserver-main)
[Tykeal's Testing Profiles](https://github.com/tykeal/puppetserver-mod-profile)
[Tykeal's Testing Roles](https://github.com/tykeal/puppetserver-mod-role)

**NOTE** the above repostories are actively for my testing of various new
modules and profiles.

## Limitations

Designed and tested against RedHat / CentOS 7.

## Development

Fork on GitHub and send PRs!
