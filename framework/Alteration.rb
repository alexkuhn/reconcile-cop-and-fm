#!/usr/bin/env ruby

require_relative 'manager/alteration/AlterationManager'

class Alteration

    class << self
        attr_accessor :manager
    end

    @manager = AlterationManager.instance

    attr_accessor :feature

    attr_accessor :type
    attr_accessor :class_name
    attr_accessor :field_name
    attr_accessor :value

    def initialize(type, class_name, field_name, value, feature)
        @type = type
        @class_name = class_name
        @field_name = field_name
        @value = value
        @feature = feature
        @manager = Alteration.manager

        Object.const_get(@class_name).class_eval("
            def proceed(*args)
                Alteration.manager.proceed(self, *args)
            end")
    end

    def apply
        @manager.apply(self)
    end

    def unapply
        @manager.unapply(self)
    end

    def alters?(type, class_name, field_name)
        @type == type and @class_name == class_name and @field_name == field_name
    end

    def deploy
        if @type == :instance_attribute
            self.deploy_instance_attribute
        elsif @type == :instance_method
            self.deploy_instance_method
        end
    end

    def deploy_instance_attribute
        c = Object.const_get(@class_name)
        c.send(:attr_accessor, @field_name)
        ObjectSpace.each_object(c) do |obj|
            obj.send(:instance_variable_set, "@#{field_name}", @value)
        end
    end

    def deploy_instance_method
        code = @value
        alteration = self
        code = self.unbind_method(code)
        klass = Object.const_get(@class_name)
        klass.send(:define_method, @field_name,
            lambda do |*args|
                Alteration.manager.proceeds.push(alteration)
                res = code.bind(self).call(*args)
                Alteration.manager.proceeds.pop
                res
            end)
    end

    def unbind_method(code)
        res = nil
        if code.is_a? Method
            res = code.unbind
        elsif code.is_a? Proc
            res = hack_proc(code)   
        end
        res
    end

    def hack_proc(a_proc)
        Object.send(:define_method, :___temp_method, &a_proc)
        res = Object.instance_method(:___temp_method)
        Object.send(:remove_method, :___temp_method)
        res
    end

    def feature_age
        if feature.nil?
            0
        else
            feature.activation_age
        end
    end

    def self.set_custom_order(feat1, feat2)
        @manager.set_custom_order(feat1, feat2)
    end

end
