#!/usr/bin/env ruby

require_relative '../../../framework/Feature'

class ShowCenteredLocation

    @@name = :show_centered_location
    @@feature = Feature.new(@@name)

    @@feature.add_alteration(
        :instance_method,
        :ERS,
        :show,
        lambda do
            "#{proceed}\n#{center_map_on_location}"
        end)
    @@feature.add_alteration(
        :instance_method,
        :ERS,
        :center_map_on_location,
        lambda do
            "centered"
        end)

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
