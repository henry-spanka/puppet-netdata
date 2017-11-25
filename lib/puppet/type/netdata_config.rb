Puppet::Type.newtype(:netdata_config) do

    ensurable

    newparam(:name, :namevar => true) do
        desc 'Section/setting name to manage from /etc/nova/api-paste.ini'
        newvalues(/\S+\/\S+/)
    end

    newproperty(:value) do
        desc 'The value of the setting to be defined.'
        munge do |value|
            value.to_s.strip
        end
        
    end

end
