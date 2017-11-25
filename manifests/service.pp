# Netdata service
class netdata::service {
    service { 'netdata':
        ensure    => 'running',
        name      => 'netdata',
        enable    => true,
        hasstatus => true,
    }

    Anchor['netdata::service::begin']
    ~> Class['netdata::service']
    -> Anchor['netdata::service::end']
}
