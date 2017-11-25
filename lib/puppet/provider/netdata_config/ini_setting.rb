Puppet::Type.type(:netdata_config).provide(
    :ini_setting,
    :parent => Puppet::Type.type(:ini_setting).provider(:ruby)
) do

    def section
        resource[:name].split('/', 2).first
    end

    def setting
        resource[:name].split('/', 2).last
    end

    def separator
        '='
    end

    def self.file_path
        '/opt/netdata/etc/netdata/netdata.conf'
    end

end
