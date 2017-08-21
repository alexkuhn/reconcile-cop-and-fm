#!/usr/bin/env ruby

require_relative 'relation/ConfigurationRelation'

require_relative 'expression/Expression'

require_relative 'algorithm/AddMandatory'
require_relative 'algorithm/AddOptional'
require_relative 'algorithm/AddOr'
require_relative 'algorithm/AddAlternative'
require_relative 'algorithm/AddAdditional'

class ActivatableDiagram

    # either :context or :feature
    attr_accessor :type

    attr_accessor :relations
    attr_accessor :expressions
    attr_accessor :algorithms

    def initialize(type)
        @type = type

        @relations    = []
        @expressions = []
        @algorithms  = {}

        @algorithms[:mandatory]   = AddMandatory.new(self)
        @algorithms[:optional]    = AddOptional.new(self)
        @algorithms[:or]          = AddOr.new(self)
        @algorithms[:alternative] = AddAlternative.new(self)
        @algorithms[:additional]  = AddAdditional.new(self)
    end

    def add_relation(type, *args)
        expressions = @algorithms[type].apply(*args)
        @relations << ConfigurationRelation.new(type, *args, expressions)
        append_expressions(expressions)
    end

    def append_expressions(expressions)
        expressions.each do |expr|
            @expressions << expr
        end
    end

    def get_conflicts
        exprs = @expressions.find_all do |e|
            not e.satisfied?
        end
        #print_expressions(exprs)
        exprs
    end

    def print_expressions(exprs)
        exprs.each do |expr|
            puts "#{expr}"
        end
    end

    def find_relations_with(type, act)
        @relations.find_all do |rel|
            rel.type == type and rel.activatables.include?(act)
        end
    end

end
