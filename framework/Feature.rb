#!/usr/bin/env ruby

require_relative 'Activatable'
require_relative 'Alteration'

class Feature < Activatable

    class << self

        attr_accessor :default

    end

    attr_accessor :alterations

    def initialize(name)
        super(name, :feature)
        @alterations = []
    end

    def self.init_default
        if Feature.default.nil?
            Feature.default = Feature.new(:fdefault)
        end
        Feature.default
    end

    def self.get(name)
        activatable = super(name)
        if activatable.is_a? Feature
            activatable
        else
            nil
        end
    end

    def self.activate(requests)
        Activatable.activate_features(requests)
    end

    def self.add_dependency_relation(type, *activatables)
        Activatable.add_feature_dependency_relation(type, *activatables)
    end

    def self.add_configuration_relation(type, *args)
        Activatable.add_feature_configuration_relation(type, *args)
    end

    def self.get_all_active
        Activatable.get_active_features
    end

    def add_alteration(type, class_name, field_name, value)
        @alterations << Alteration.new(type, class_name, field_name, value, self)
    end

    def apply_alterations
        @alterations.each do |a|
            a.apply
        end
    end

    def unapply_alterations
        @alterations.each do |a|
            a.unapply
        end
    end

    def activate
        Feature.activate({:activation => [self]})
    end

    def deactivate
        Feature.activate({:deactivation => [self]})
    end

	def active?
		Activatable.feature_active?(self)
	end

	def inactive?
	   Activatable.feature_inactive?(self)
	end

	def to_s
		"feature: #{@name}"
	end

    @default = Feature.init_default

end
