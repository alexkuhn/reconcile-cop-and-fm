#!/usr/bin/env ruby

class Store

    attr_accessor :activatables

    def initialize
		@activatables = []
	end

    def add_activatable(activatable)
        @activatables << activatable
    end

    def get_activatable(act_name)
        @activatables.find do |act|
            act.name == act_name
        end
    end

    def get_active_contexts
        @activatables.find_all do |act|
            act.type == :context and act.active?
        end
    end

    def get_active_features
        @activatables.find_all do |act|
            act.type == :feature and act.active?
        end
    end

    def get_inactive_features
        @activatables.find_all do |act|
            act.type == :feature and act.inactive?
        end
    end

end
