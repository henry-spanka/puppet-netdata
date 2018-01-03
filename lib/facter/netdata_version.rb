Facter.add(:netdata_version) do
    setcode do
        version = nil
        if File.exists? "/opt/netdata/version"
            version = File.open('/opt/netdata/version') {|f| f.readline.chomp}
        end
        version
    end
end
