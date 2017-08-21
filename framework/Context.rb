#!/usr/bin/env ruby

require_relative 'Activatable'

class Context < Activatable	

    class << self
        
        attr_accessor :default        

    end

    def initialize(name)
        super(name, :context)
    end

    def self.init_default
        if Context.default.nil?
            Context.default = Context.new(:default)
        end
        Context.default
    end

    def self.get(name)
        activatable = super(name)
        if activatable.is_a? Context
            activatable
        else
            nil
        end
    end

    def self.activate(requests)
        Activatable.activate_contexts(requests)
    end

    def self.add_dependency_relation(type, *activatables)
        Activatable.add_context_dependency_relation(type, *activatables)
    end

    def self.add_configuration_relation(type, *args)
        Activatable.add_context_configuration_relation(type, *args) 
    end

    def self.get_all_active
        Activatable.get_active_contexts
    end

    def activate
        Context.activate({:activation => [self]})
    end

    def deactivate
        Context.activate({:deactivation => [self]})
    end

	def active?
		Activatable.context_active?(self)
	end

	def inactive?
		Activatable.context_inactive?(self)
	end

    def to_s
        "context: #{@name}"
    end

    @default = Context.init_default

end
