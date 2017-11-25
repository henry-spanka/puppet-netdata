# Install netdata
class netdata::install {
    file { '/opt/netdata':
        ensure => 'directory',
        owner  => 'root',
    }
    -> file { '/opt/netdata/kickstart-static64.sh':
        ensure => 'file',
        mode   => '0750',
        source => 'puppet:///modules/netdata/kickstart-static64.sh'
    }
    ~> exec { 'install_netdata_package':
        command     => 'sh /opt/netdata/kickstart-static64.sh --dont-wait',
        refreshonly => true,
        path        => ['/usr/bin', '/bin', '/usr/sbin'],
    }

    Anchor['netdata::install::begin']
    -> Class['netdata::install']
    -> Anchor['netdata::install::end']

}
