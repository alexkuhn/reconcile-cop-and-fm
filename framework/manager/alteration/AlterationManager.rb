#!/usr/bin/env ruby

require_relative 'policy/CompositionPolicy'

require 'singleton'
require 'set'

class AlterationManager
	include Singleton

	attr_accessor :applied_alterations
	attr_accessor :policy
	attr_accessor :proceeds

    def initialize
        @applied_alterations = Set.new
        @policy = CompositionPolicy.new
        @proceeds = []
    end

    def apply(alteration)
        add_applied(alteration)
        best_alt(alteration).deploy
    end

    def unapply(alteration)
        remove_applied(alteration)
        b = best_alt(alteration)
        if not b.nil?
            b.deploy
        end
    end

    def add_applied(alteration)
        @applied_alterations << alteration
    end

    def remove_applied(alteration)
        @applied_alterations.delete(alteration)
    end

    def best_alt(alteration)
        a = alteration_chain(alteration).first
        if a.nil?
            clear_field(alteration)
        end
        a
    end

    def alteration_chain(alteration)
        type = alteration.type
        class_name = alteration.class_name
        field_name = alteration.field_name
        alts = @applied_alterations.find_all do |a|
            a.alters?(type, class_name, field_name)
        end
        @policy.do_sort(alts)
    end

    def set_custom_order(feat1, feat2)
        @policy.set_custom_order(feat1, feat2)
    end

    def proceed(obj, *args)
        curr = @proceeds.last
        self.alteration_after(curr).deploy
        res = obj.send(curr.field_name, *args)
        curr.deploy
        res
    end

    def alteration_after(curr)
        sub_chain = alteration_chain(curr).drop_while do |x|
            x != curr
        end
        sub_chain[1]
    end

    def clear_field(alteration)
        if alteration.type == :instance_attribute
            clear_attribute(alteration)
        else #:instance_method
            clear_method(alteration)
        end
    end

    def clear_attribute(alteration)
        klass = Object.const_get(alteration.class_name)
        f = "@#{alteration.field_name}".to_sym
        ObjectSpace.each_object(klass) do |object|
            if object.instance_variable_defined?(f)
                object.send(:remove_instance_variable, f)
            end
        end
    end

    def clear_method(alteration)
        klass = Object.const_get(alteration.class_name)
        if klass.method_defined?(alteration.field_name)
            klass.send(:remove_method, alteration.field_name)
        end
    end

end
