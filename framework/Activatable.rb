#!/usr/bin/env ruby

require_relative 'manager/activatable/ActivatableManager'

class Activatable

    class << self
        attr_accessor :manager
        attr_accessor :last_continuation
    end

    @last_continuation = 0

    @manager = ActivatableManager.instance

    attr_accessor :name
    attr_accessor :type

	def initialize(name, type)
		@name = name
        @type = type

        @continuation = 0
        
        @manager = Activatable.manager
        @manager.add_activatable(self)
	end

    def self.get(act_name)
        Activatable.manager.get_activatable(act_name)
    end

    def self.add_context_dependency_relation(type, *activatables)
        Activatable.manager.add_context_dependency_relation(type, *activatables)
    end

    def self.add_feature_dependency_relation(type, *activatables)
        Activatable.manager.add_feature_dependency_relation(type, *activatables)
    end

    def self.add_context_configuration_relation(type, *args)
        Activatable.manager.add_context_configuration_relation(type, *args)
    end

    def self.add_feature_configuration_relation(type, *args)
        Activatable.manager.add_feature_configuration_relation(type, *args)
    end

    def self.activate_contexts(requests)
        Activatable.manager.activate_contexts(requests)
    end

    def self.activate_features(requests)
        Activatable.manager.activate_features(requests)
    end

    def self.add_mapping(type, context, feature)
        Activatable.manager.add_mapping(type, context, feature)
    end

    def self.context_active?(activatable)
        Activatable.manager.context_active?(activatable)
    end

    def self.feature_active?(activatable)
        Activatable.manager.feature_active?(activatable)
    end

    def self.context_inactive?(activatable)
        Activatable.manager.context_inactive?(activatable)
    end

    def self.feature_inactive?(activatable)
        Activatable.manager.feature_inactive?(activatable)
    end

    def self.get_active_contexts
        Activatable.manager.get_active_contexts
    end

    def self.get_active_features
        Activatable.manager.get_active_features
    end

    def self.get_continuation
        @last_continuation += 1
        @last_continuation
    end

    def update_continuation
        @continuation = Activatable.get_continuation
    end

    def activation_age
        Activatable.last_continuation - @continuation
    end

    def activate
    end

    def deactivate
    end

	def active?
		# todo
	end

	def inactive?
		# todo
	end

    def to_s
        "activatable: #{@name}, #{@type}"
    end

end
