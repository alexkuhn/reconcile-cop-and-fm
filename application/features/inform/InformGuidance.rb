#!/usr/bin/env ruby

require_relative '../../../framework/Feature'

class InformGuidance

    @@name = :inform_guidance
    @@feature = Feature.new(@@name)

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
