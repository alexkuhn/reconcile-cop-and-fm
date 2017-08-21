#!/usr/bin/env ruby

require_relative '../../../framework/Feature'

class ShowEmergenciesOnMap

    @@name = :show_emergencies_on_map
    @@feature = Feature.new(@@name)

    @@feature.add_alteration(
        :instance_method,
        :ERS,
        :show_on_map,
        lambda do
            "#{proceed},\n\t\t\tEmergencies"
        end)

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
