#!/usr/bin/env ruby

require_relative '../../../framework/Feature'

class GuideOutOfDanger

    @@name = :guide_out_of_danger
    @@feature = Feature.new(@@name)

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
