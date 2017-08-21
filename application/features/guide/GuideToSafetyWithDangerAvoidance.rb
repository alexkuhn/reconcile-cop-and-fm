#!/usr/bin/env ruby

require_relative '../../../framework/Feature'

class GuideToSafetyWithDangerAvoidance

    @@name = :guide_to_safety_with_danger_avoidance
    @@feature = Feature.new(@@name)

    @@feature.add_alteration(
        :instance_method,
        :ERS,
        :guide,
        lambda do
            "#{guide_out_of_danger}, then #{guide_to_safety} while Avoiding any Danger."
        end)

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
