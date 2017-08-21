#!/usr/bin/env ruby

require_relative '../../../framework/Feature'
require_relative '../../classes/ERSSafePlace'

class InformSafePlaces

    @@name = :inform_safe_places
    @@feature = Feature.new(@@name)

    @@feature.add_alteration(
        :instance_method,
        :ERS,
        :inform,
        lambda do
            "#{proceed}\n#{inform_safe_places}"
        end)
    @@feature.add_alteration(
        :instance_method,
        :ERS,
        :inform_safe_places,
        lambda do
            s = "\t Safe Places:\n"
            i = 1
            @safe_places.each do |sp|
                s += "\t    #{i}. \t#{sp.name}\n"
                sp.properties.each do |name, value|
                    s += "\t\t#{name}: #{value}\n"
                end
                i += 1
            end
            s
        end)
    @@feature.add_alteration(
        :instance_attribute,
        :ERS,
        :safe_places,
        [ ERSSafePlace.new(:ucl), ERSSafePlace.new(:uzleuven) ])

    def self.get
        @@feature
    end

    def self.name
        @@name
    end

end
