#!/usr/bin/env ruby

require_relative 'relation/DependencyRelation'

require_relative 'element/Element'

require_relative 'algorithm/AddSingleton'
require_relative 'algorithm/AddExclusion'
require_relative 'algorithm/AddRequirement'
require_relative 'algorithm/AddCausality'
require_relative 'algorithm/AddImplication'
require_relative 'algorithm/AddConjunction'
require_relative 'algorithm/AddDisjunction'

class ActivatablePetriNet

    # either :context or :feature
    attr_accessor :type

    attr_accessor :relations
    attr_accessor :elements
    attr_accessor :algorithms

    def initialize(type)
        @type = type

        @relations  = []
        @elements   = []
        @algorithms = {}

        @algorithms[:singleton]   = AddSingleton.new(self)
        @algorithms[:exclusion]   = AddExclusion.new(self)
        @algorithms[:requirement] = AddRequirement.new(self)
        @algorithms[:causality]   = AddCausality.new(self)
        @algorithms[:implication] = AddImplication.new(self)
        @algorithms[:conjunction] = AddConjunction.new(self)
        @algorithms[:disjunction] = AddDisjunction.new(self)
    end

    def add_activatable(activatable)
        @algorithms[:singleton].apply_ext(activatable)
    end

    def add_relation(type, *activatables)
        @relations << DependencyRelation.new(type, *activatables)
        reapply_dependencies
    end

    def reapply_dependencies
        remove_dependencies
        @relations.each do |rel|
            @algorithms[rel.type].apply_ext(rel.activatables)
        end
        @relations.each do |rel|
            @algorithms[rel.type].apply_cons(rel.activatables)
        end
    end

    def remove_dependencies
        # get all dependency elements
        dependency_elements = @elements.find_all do |e|
            e.category == :dependency
        end
        # remove their connectors (arcs)
        dependency_elements.each do |e|
            e.remove_connectors
        end
        # remove dependency elements from the elements
        dependency_elements.each do |e|
            @elements.delete(e)
        end

        # reset id for dependency elements
        Element.reset_did
    end

    def request_activations(requests)
        requests.each do |type, acts|
            acts.each do |act|
                find_external_transition(type, act).fire
            end
        end
    end

    def find_external_transition(request_type, activatable)
        @elements.find do |e|
            e.type == :external_transition and e.active_state == request_type and e.activatable == activatable
        end
    end

    def reactive_enforce_dependencies
        its = find_enabled_int_transitions
        while not its.empty? do
            its.sample.fire
            its = find_enabled_int_transitions
        end
    end

    def find_enabled_int_transitions
        @elements.find_all do |e|
            e.type == :internal_transition and e.enabled?
        end
    end

    def active?(activatable)
        ap = find_activatable_place(activatable)
        if not ap.nil?
            ap.tokens > 0
        else
            nil
        end
    end

    def inactive?(activatable)
        ap = find_activatable_place(activatable)
        if not ap.nil?
            ap.tokens == 0
        else
            nil
        end
    end

    def find_activatable_place(act)
        @elements.find do |e|
            e.type == :activatable_place and e.activatable == act
        end
    end

    def get_conflicts
        @elements.find_all do |e|
            e.type == :temporary_place and e.tokens > 0
        end
    end

    def find_relations_with(type, act)
        @relations.find_all do |rel|
            rel.type == type and rel.activatables.include?(act)
        end
    end

end
