#!/usr/bin/env ruby

require_relative '../../../framework/Feature'

class ShowUSAMap

    @@name = :show_usa_map
    @@feature = Feature.new(@@name)

    @@feature.add_alteration(
        :instance_method,
        :ERS,
        :center_map_on_location,
        lambda do
            "#{proceed}\n\t\t\tOn the USA."
        end)

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
