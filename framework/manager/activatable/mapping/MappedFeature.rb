#!/usr/bin/env ruby

require_relative 'MappedActivatable'
require_relative 'MappedContext'

class MappedFeature < MappedActivatable

    attr_accessor :enabling_contexts
    attr_accessor :disabling_contexts

    def initialize(feature)
		super(feature)
        @enabling_contexts  = []
        @disabling_contexts = []
	end

    def add(type, context)
        if type == :enabler
            @enabling_contexts << MappedContext.new(context)
        else # :disabler
            @disabling_contexts << MappedContext.new(context)
        end
    end

    def select_feature
        e = any_enabling_active?
        d = any_disabling_active?
        if e and not d and @activatable.inactive?
            {:activation => [@activatable]}
        elsif d and @activatable.active?
            {:deactivation => [@activatable]}
        elsif not e and not d and @activatable.active?
            {:deactivation => [@activatable]}
        else
            nil
        end
    end

    def any_enabling_active?
        @enabling_contexts.any? do |mapped_ctx|
            mapped_ctx.active?
        end
    end

    def any_disabling_active?
        @disabling_contexts.any? do |mapped_ctx|
            mapped_ctx.active?
        end
    end

    def to_s
        "mapped feature: #{@activatable}\n#{enabling_to_s}#{disabling_to_s}\n"
    end

    def enabling_to_s
        s = "enabling:\n"
        @enabling_contexts.each do |e|
            s += "#{e}\n"
        end
        s
    end

    def disabling_to_s
        s = "disabling:\n"
        @disabling_contexts.each do |d|
            s += "#{d}\n"
        end
        s
    end

end
