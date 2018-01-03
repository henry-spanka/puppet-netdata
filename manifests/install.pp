# Install netdata
class netdata::install (
    String $version = 'latest',
    String $base = 'https://raw.githubusercontent.com/firehol/binary-packages/master',
) {
    if (!$::netdata_version or $::netdata_version != $version) {
        $install = 'yes'
    } else {
        $install = 'no'
    }

    include netdata::service

    file { '/opt/netdata':
        ensure => 'directory',
        owner  => 'root',
    }
    -> file { '/opt/netdata/kickstart-static64.sh':
        ensure => 'file',
        mode   => '0750',
        source => 'puppet:///modules/netdata/kickstart-static64.sh'
    }
    -> exec { 'install_netdata_package':
        command => "sh /opt/netdata/kickstart-static64.sh --dont-wait '${base}' '${version}'",
        onlyif  => "echo ${install} | grep yes",
        path    => ['/usr/bin', '/bin', '/usr/sbin'],
        notify  => Service['netdata'],
    }

    file { '/opt/netdata/version':
        ensure  => 'file',
        mode    => '0644',
        owner   => 'netdata',
        group   => 'netdata',
        content => $version,
        require => Exec['install_netdata_package'],
    }

    Anchor['netdata::install::begin']
    -> Class['netdata::install']
    -> Anchor['netdata::install::end']

}
