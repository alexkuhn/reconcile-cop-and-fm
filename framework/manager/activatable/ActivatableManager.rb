#!/usr/bin/env ruby

require_relative 'store/Store'
require_relative 'mapping/Mapping'
require_relative 'model/ActivatableModel'

require 'singleton'

class ActivatableManager
	include Singleton

	attr_accessor :store
	attr_accessor :mapping
	attr_accessor :context_model
	attr_accessor :feature_model

    def initialize
        @store = Store.new
        @mapping = Mapping.new
        @context_model = ActivatableModel.new(:context)
        @feature_model = ActivatableModel.new(:feature)
    end

    def add_activatable(activatable)
        @store.add_activatable(activatable)
        if activatable.type == :context
            @context_model.add_activatable(activatable)
        else # feature
            @feature_model.add_activatable(activatable)
        end
    end

    def activate_contexts(requests)
        @context_model.activate(requests)
        reqs = @mapping.select_features
        activate_features(reqs)
    end

    def activate_features(requests)
        @feature_model.activate(requests)
        execute_features
    end

    def execute_features
        active_feats   = @store.get_active_features
        inactive_feats = @store.get_inactive_features

        active_feats.each do |f|
            f.apply_alterations
        end
        inactive_feats.each do |f|
            f.unapply_alterations
        end
    end

    def context_active?(activatable)
        # true or false or nil (nil when context doesn't exist)
        @context_model.active?(activatable)
    end

    def feature_active?(activatable)
        # true or false or nil (nil when feature doesn't exist)
        @feature_model.active?(activatable)
    end

    def context_inactive?(activatable)
        # true or false or nil (nil when context doesn't exist)
        @context_model.inactive?(activatable)
    end

    def feature_inactive?(activatable)
        # true or false or nil (nil when feature doesn't exist)
        @feature_model.inactive?(activatable)
    end

    def get_activatable(name)
        @store.get_activatable(name)
    end

    def get_active_contexts
        @store.get_active_contexts
    end

    def get_active_features
        @store.get_active_features
    end

    def add_context_dependency_relation(type, *activatables)
        @context_model.add_dependency_relation(type, *activatables)
    end

    def add_feature_dependency_relation(type, *activatables)
        @feature_model.add_dependency_relation(type, *activatables)
    end

    def add_context_configuration_relation(type, *args)
        @context_model.add_configuration_relation(type, *args)
    end

    def add_feature_configuration_relation(type, *args)
        @feature_model.add_configuration_relation(type, *args)
    end

    def add_mapping(type, context, feature)
        @mapping.add_mapping(type, context, feature)
    end

end
