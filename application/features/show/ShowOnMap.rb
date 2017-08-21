#!/usr/bin/env ruby

require_relative '../../../framework/Feature'

class ShowOnMap

    @@name = :show_on_map
    @@feature = Feature.new(@@name)

    @@feature.add_alteration(
        :instance_method,
        :ERS,
        :show,
        lambda do
            "#{proceed}#{show_on_map}.\n\t\t"
        end)
    @@feature.add_alteration(
        :instance_method,
        :ERS,
        :show_on_map,
        lambda do
            "Visual info:"
        end)

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
