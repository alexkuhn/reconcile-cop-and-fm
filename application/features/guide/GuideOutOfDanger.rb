#!/usr/bin/env ruby

require_relative '../../../framework/Feature'

class GuideOutOfDanger

    @@name = :guide_out_of_danger
    @@feature = Feature.new(@@name)

    @@feature.add_alteration(
        :instance_method,
        :ERS,
        :guide,
        lambda do
            "#{guide_out_of_danger}."
        end)
    @@feature.add_alteration(
        :instance_method,
        :ERS,
        :guide_out_of_danger,
        lambda do
            "Guide User Out of Danger"
        end)

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
