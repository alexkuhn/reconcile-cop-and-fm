#!/usr/bin/env ruby

require_relative '../../../framework/Feature'

class GuideToSafety

    @@name = :guide_to_safety
    @@feature = Feature.new(@@name)

    @@feature.add_alteration(
        :instance_method,
        :ERS,
        :guide,
        lambda do
            "#{guide_to_safety}."
        end)
    @@feature.add_alteration(
        :instance_method,
        :ERS,
        :guide_to_safety,
        lambda do
            "Guide User To the nearest Safe Place"
        end)

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
