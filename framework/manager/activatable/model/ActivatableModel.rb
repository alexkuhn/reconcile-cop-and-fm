#!/usr/bin/env ruby

require_relative 'strategy/ConflictStrategy'
require_relative 'dependency/ActivatablePetriNet'
require_relative 'configuration/ActivatableDiagram'

class ActivatableModel

    # either :context or :feature
    attr_accessor :type

    attr_accessor :strategy
    attr_accessor :dependency_model
    attr_accessor :configuration_model

    def initialize(type)
		@type = type

        @strategy = ConflictStrategy.new(self)
        
        @dependency_model = ActivatablePetriNet.new(type)
        @configuration_model = ActivatableDiagram.new(type)
	end

    def add_activatable(activatable)
        @dependency_model.add_activatable(activatable)
    end

    def add_dependency_relation(type, *activatables)
        @dependency_model.add_relation(type, *activatables)
    end

    def add_configuration_relation(type, *args)
        @configuration_model.add_relation(type, *args)
    end

    def active?(activatable)
        @dependency_model.active?(activatable)
    end

    def inactive?(activatable)
        @dependency_model.inactive?(activatable)
    end

    def activate(requests)
        # strategy remembers requests for rollback
        @strategy.set_requests(requests)

        request_activations(requests)
        reactive_enforce_dependencies
        resolve_conflicts
    end

    def request_activations(requests)
        @dependency_model.request_activations(requests)
    end

    def reactive_enforce_dependencies
        @dependency_model.reactive_enforce_dependencies
    end

    def resolve_conflicts
        @strategy.resolve_conflicts
    end

    def get_conflicts
        conflicts = {}
        dep_cs = @dependency_model.get_conflicts
        if not dep_cs.empty?
            conflicts[:dependency] = dep_cs
        end
        conf_cs = @configuration_model.get_conflicts
        if not conf_cs.empty?
            conflicts[:configuration] = conf_cs
        end
        conflicts
    end

    def find_dependency_relations_with(type, act)
        @dependency_model.find_relations_with(type, act)
    end

    def find_configuration_relations_with(type, act)
        @configuration_model.find_relations_with(type, act)
    end

end
