#!/usr/bin/env ruby

require_relative '../../../framework/Feature'

class GuideUser

    @@name = :guide_user
    @@feature = Feature.new(@@name)

    @@feature.add_alteration(
        :instance_method,
        :ERS,
        :guide,
        lambda do
            "Guide user."
        end)

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
