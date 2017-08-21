#!/usr/bin/env ruby

require_relative '../../../framework/Feature'
require_relative '../../classes/ERSEarthquake'

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
            s = "information on emergencies:\n"
            i = 1
            @emergencies.each do |e|
                s += "\t#{i}. \t#{e.type}\n"
                e.properties.each do |name, value|
                    s += "\t\t#{name}: #{value}\n"
                end
                i += 1
            end
            s
        end)
    @@feature.add_alteration(
        :instance_attribute,
        :ERS,
        :emergencies,
        [ ERSEarthquake.new ])

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
