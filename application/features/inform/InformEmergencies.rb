#!/usr/bin/env ruby

require_relative '../../../framework/Context'
require_relative '../../../framework/Feature'
require_relative '../../classes/ERSEarthquake'
require_relative '../../classes/ERSWildfire'

class InformEmergencies

    @@name = :inform_emergencies
    @@feature = Feature.new(@@name)

    @@feature.add_alteration(
        :instance_method,
        :ERS,
        :inform,
        lambda do
            "#{proceed}\n#{inform_emergencies}"
        end)
    @@feature.add_alteration(
        :instance_method,
        :ERS,
        :inform_emergencies,
        lambda do
            s = "\t Emergencies:\n"
            i = 1
            @emergencies.each do |e|
                if (Context.get(:earthquake).active? and e.type == :Earthquake) or
                    (Context.get(:wildfire).active? and e.type == :Wildfire)
                    s += "\t    #{i}. \t#{e.type}\n"
                    e.properties.each do |name, value|
                        s += "\t\t#{name}: #{value}\n"
                    end
                    i += 1
                end
            end
            s
        end)
    @@feature.add_alteration(
        :instance_attribute,
        :ERS,
        :emergencies,
        [ ERSEarthquake.new, ERSWildfire.new ])

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
