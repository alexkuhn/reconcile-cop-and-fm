#!/usr/bin/env ruby

require_relative '../../../framework/Feature'

class ShowEuropeanMap

    @@name = :show_european_map
    @@feature = Feature.new(@@name)

    @@feature.add_alteration(
        :instance_method,
        :ERS,
        :center_map_on_location,
        lambda do
            "#{proceed} on Europe"
        end)

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
