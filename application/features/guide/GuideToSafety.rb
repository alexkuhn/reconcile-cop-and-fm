#!/usr/bin/env ruby

require_relative '../../../framework/Feature'

class GuideToSafety

    @@name = :guide_to_safety
    @@feature = Feature.new(@@name)

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
