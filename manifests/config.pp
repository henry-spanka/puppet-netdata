# Configure Netdata Config
class netdata::config {
    resources { 'netdata_config':
        purge => true,
    }

}
