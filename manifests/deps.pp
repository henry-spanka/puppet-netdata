# Dependencies
class netdata::deps {
    anchor { 'netdata::install::begin': }
    -> anchor { 'netdata::install::end': }
    -> anchor { 'netdata::config::begin': }
    -> Netdata_config <||>
    ~> anchor { 'netdata::config::end': }
    ~> anchor { 'netdata::service::begin': }
    -> anchor { 'netdata::service::end': }

    Anchor['netdata::install::end'] ~> Anchor['netdata::service::begin']
}
