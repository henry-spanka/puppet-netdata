# Class: netdata
# ===========================
#
# Full description of class netdata here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'netdata':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class netdata (
    String $web_bind = '*',
    Boolean $enable_backend = False,
    String $destination = 'tcp:localhost:2003',
    String $data_source = 'average',
    String $update_every = '10',
    String $prefix = 'netdata',
    # Latest version will not update after installed
    String $version = 'latest',
    String $base = 'https://raw.githubusercontent.com/firehol/binary-packages/master',
) {

    include netdata::deps

    class { 'netdata::install':
        version => $version,
        base    => $base,
    }
    include netdata::config
    include netdata::service

    netdata_config {
        'web/bind to':  value => $web_bind;
    }

    if ($enable_backend) {
        # lint:ignore:duplicate_params
        netdata_config {
            'backend/enabled':                          value => 'yes';
            'backend/type':                             value => 'graphite';
            'backend/destination':                      value => $destination;
            'backend/data source':                      value => $data_source;
            'backend/update every':                     value => $update_every;
            'backend/prefix':                           value => $prefix;
            'backend/send names instead of ids': value => 'yes';
        }
        # lint:endignore
    } else {
        netdata_config {
            'backend/enabled':  value => 'no';
        }
    }

}
