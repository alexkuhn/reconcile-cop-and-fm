#!/usr/bin/env ruby

require_relative '../../framework/Alteration'

require 'singleton'

class InitCustomComposition
    include Singleton
    
    def initialize
        custom_composition
    end

    def custom_composition
        Alteration.set_custom_order(
            :show_on_map,
            :show_map)
        Alteration.set_custom_order(
            :show_centered_location,
            :show_map)
        Alteration.set_custom_order(
            :show_on_map,
            :show_centered_location)
        Alteration.set_custom_order(
            :show_belgian_map,
            :show_european_map)
        Alteration.set_custom_order(
            :alert_in_danger,
            :alert_emergencies)
    end

end

InitCustomComposition.instance