#!/usr/bin/env ruby

# LOCATION related contexts
require_relative 'location/Location'
require_relative 'location/USA'
require_relative 'location/Europe'
require_relative 'location/Belgium'

# CONNECTIVITY related contexts
require_relative 'connectivity/Connectivity'
require_relative 'connectivity/WiFi'
require_relative 'connectivity/LTE'

# EMERGENCY related contexts
require_relative 'emergency/Emergency'
require_relative 'emergency/Earthquake'
require_relative 'emergency/Wildfire'

# BATTERY related contexts
require_relative 'battery/Battery'
require_relative 'battery/LowBattery'
require_relative 'battery/HighBattery'

# INDANGER related contexts
require_relative 'indanger/InDanger'

# MAP related contexts
require_relative 'map/Map'
require_relative 'map/USAMap'
require_relative 'map/EuropeanMap'
require_relative 'map/BelgianMap'

# abstract contexts
require_relative 'abstract/ConnectedAndLocated'


require 'singleton'

class InitContexts
    include Singleton
    
    attr_accessor :ctxs

    def initialize
        relations
    end

    def relations
        dependency_relations
        configuration_relations
    end

    def dependency_relations
        # exclusion
        Context.add_dependency_relation(
            :exclusion,
            LowBattery.get,
            HighBattery.get)
        Context.add_dependency_relation(
            :exclusion,
            Europe.get,
            USA.get)

        # requirement
        Context.add_dependency_relation(
            :requirement,
            InDanger.get,
            Emergency.get)

        # causality
        Context.add_dependency_relation(
            :causality,
            Context.default,
            USA.get)
        Context.add_dependency_relation(
            :causality,
            Context.default,
            LTE.get)
        Context.add_dependency_relation(
            :causality,
            ConnectedAndLocated.get,
            Map.get)

        # implication
        Context.add_dependency_relation(
            :implication,
            Belgium.get,
            Europe.get)

        # conjunction
        Context.add_dependency_relation(
            :conjunction,
            ConnectedAndLocated.get,
            Connectivity.get,
            Location.get)
        Context.add_dependency_relation(
            :conjunction,
            USAMap.get,
            Map.get,
            USA.get)
        Context.add_dependency_relation(
            :conjunction,
            EuropeanMap.get,
            Map.get,
            Europe.get)
        Context.add_dependency_relation(
            :conjunction,
            BelgianMap.get,
            Map.get,
            Belgium.get)

        # disjunction
        Context.add_dependency_relation(
            :disjunction,
            Connectivity.get,
            WiFi.get,
            LTE.get)
        Context.add_dependency_relation(
            :disjunction,
            Location.get,
            Europe.get,
            USA.get)
        Context.add_dependency_relation(
            :disjunction,
            Battery.get,
            LowBattery.get,
            HighBattery.get)
        Context.add_dependency_relation(
            :disjunction,
            Emergency.get,
            Earthquake.get,
            Wildfire.get)
    end

    def configuration_relations
        # DEFAULT-related
        Context.add_configuration_relation(
            :mandatory,
            Context.default,
            Location.get)
        Context.add_configuration_relation(
            :optional,
            Context.default,
            Connectivity.get)
        Context.add_configuration_relation(
            :optional,
            Context.default,
            Emergency.get)
        Context.add_configuration_relation(
            :optional,
            Context.default,
            Battery.get)
        Context.add_configuration_relation(
            :optional,
            Context.default,
            Battery.get)
        Context.add_configuration_relation(
            :optional,
            Context.default,
            InDanger.get)
        Context.add_configuration_relation(
            :optional,
            Context.default,
            Map.get)

        # LOCATION-related
        Context.add_configuration_relation(
            :alternative,
            Location.get,
            Europe.get,
            USA.get)
        Context.add_configuration_relation(
            :optional,
            Europe.get,
            Belgium.get)

        # CONNECTIVITY-related
        Context.add_configuration_relation(
            :or,
            Connectivity.get,
            WiFi.get,
            LTE.get)

        # EMERGENCY-related
        Context.add_configuration_relation(
            :optional,
            Emergency.get,
            Earthquake.get)
        Context.add_configuration_relation(
            :optional,
            Emergency.get,
            Wildfire.get)

        # BATTERY-related
        Context.add_configuration_relation(
            :alternative,
            Battery.get,
            LowBattery.get,
            HighBattery.get)

        # MAP-related
        Context.add_configuration_relation(
            :alternative,
            Map.get,
            USAMap.get,
            EuropeanMap.get)
        Context.add_configuration_relation(
            :optional,
            EuropeanMap.get,
            BelgianMap.get)

        # additional
        Context.add_configuration_relation(
            :additional,
            [   :implication,
                Map.get,
                [   :conjunction,
                    Location.get,
                    Connectivity.get ]])
        Context.add_configuration_relation(
            :additional,
            [   :implication,
                InDanger.get,
                Emergency.get ])
    end

end

InitContexts.instance