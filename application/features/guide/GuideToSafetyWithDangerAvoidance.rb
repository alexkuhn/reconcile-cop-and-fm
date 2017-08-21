#!/usr/bin/env ruby

require_relative '../../../framework/Feature'

class GuideToSafetyWithDangerAvoidance

    @@name = :guide_to_safety_with_danger_avoidance
    @@feature = Feature.new(@@name)

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
