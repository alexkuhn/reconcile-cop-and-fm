#!/usr/bin/env ruby

require_relative '../../../framework/Feature'

class ShowMap

    @@name = :show_map
    @@feature = Feature.new(@@name)

    @@feature.add_alteration(
        :instance_method,
        :ERS,
        :show,
        lambda do
            "showing a map"
        end)

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
