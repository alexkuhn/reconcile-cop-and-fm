#!/usr/bin/env ruby

require_relative '../../framework/Activatable'
require_relative '../../framework/Context'
require_relative '../../framework/Feature'

require 'singleton'

class InitMapping
    include Singleton
    
    attr_accessor :feats

    def initialize
        mapping
    end

    def mapping
        Activatable.add_mapping(
            :enabler,
            Context.get(:usa),
            Feature.get(:inform_usa_emergency_call))
        Activatable.add_mapping(
            :enabler,
            Context.get(:europe),
            Feature.get(:inform_european_emergency_call))
        Activatable.add_mapping(
            :enabler,
            Context.get(:emergency),
            Feature.get(:inform_and_alert_emergencies))
        Activatable.add_mapping(
            :enabler,
            Context.get(:in_danger),
            Feature.get(:alert_in_danger))
        Activatable.add_mapping(
            :enabler,
            Context.get(:map),
            Feature.get(:show_map))
        Activatable.add_mapping(
            :enabler,
            Context.get(:belgian_map),
            Feature.get(:show_belgian_map))
        Activatable.add_mapping(
            :enabler,
            Context.get(:european_map),
            Feature.get(:show_european_map))
        Activatable.add_mapping(
            :enabler,
            Context.get(:usa_map),
            Feature.get(:show_usa_map))
        Activatable.add_mapping(
            :disabler,
            Context.get(:low_battery),
            Feature.get(:show_map))
    end

end

InitMapping.instance