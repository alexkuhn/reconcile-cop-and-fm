#!/usr/bin/env ruby

require_relative '../../../framework/Feature'
require_relative '../../classes/Earthquake'

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
            s = "information on emergencies:"
            i = 1
            @emergencies.each do |e|
                s += "#{i}. \t{e.type}\n"
                e.properties.each do |p|
                    s += "\t#{p.name}: #{p.value}\n"
                end
                s += "\n"
                i += 1
            end
            s
        end)
    @@feature.add_alteration(
        :instance_attribute,
        :ERS,
        :emergencies,
        [ Earthquake.new ])

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
