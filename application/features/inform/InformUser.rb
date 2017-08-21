#!/usr/bin/env ruby

require_relative '../../../framework/Feature'

class InformUser

    @@name = :inform_user
    @@feature = Feature.new(@@name)

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
