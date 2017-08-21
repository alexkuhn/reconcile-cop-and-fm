#!/usr/bin/env ruby

require_relative '../../../framework/Feature'

class ShowGuidanceOnMap

    @@name = :show_guidance_on_map
    @@feature = Feature.new(@@name)

    @@feature.add_alteration(
        :instance_method,
        :ERS,
        :show_on_map,
        lambda do
            "#{proceed}\n\tguidance route"
        end)

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
