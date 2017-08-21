#!/usr/bin/env ruby

# INFORM-related features
require_relative 'inform/InformUser'
require_relative 'inform/InformGeneralInstructions'
require_relative 'inform/InformEmergencies'
require_relative 'inform/InformSafePlaces'
require_relative 'inform/InformGuidance'
require_relative 'inform/InformUSAEmergencyCall'
require_relative 'inform/InformEuropeanEmergencyCall'

# ALERT-related features
require_relative 'alert/AlertUser'
require_relative 'alert/AlertEmergencies'
require_relative 'alert/AlertInDanger'

# SHOW-related features
require_relative 'show/ShowMap'
require_relative 'show/ShowCenteredLocation'
require_relative 'show/ShowUSAMap'
require_relative 'show/ShowEuropeanMap'
require_relative 'show/ShowBelgianMap'
require_relative 'show/ShowOnMap'
require_relative 'show/ShowUserOnMap'
require_relative 'show/ShowEmergenciesOnMap'
require_relative 'show/ShowSafePlacesOnMap'
require_relative 'show/ShowGuidanceOnMap'

# GUIDE-related features
require_relative 'guide/GuideUser'
require_relative 'guide/GuideOutOfDanger'
require_relative 'guide/GuideToSafety'
require_relative 'guide/GuideToSafetyWithDangerAvoidance'

# abstract features
require_relative 'abstract/InformAndAlertEmergencies'


require 'singleton'

class InitFeatures
    include Singleton
    
    attr_accessor :feats

    def initialize
        relations
    end

    def relations
        dependency_relations
        configuration_relations
    end

    def dependency_relations
        # exclusion
        Feature.add_dependency_relation(
            :exclusion,
            ShowEuropeanMap.get,
            ShowUSAMap.get)
        Feature.add_dependency_relation(
            :exclusion,
            InformEuropeanEmergencyCall.get,
            InformUSAEmergencyCall.get)

        # requirement
        Feature.add_dependency_relation(
            :requirement,
            ShowBelgianMap.get,
            ShowCenteredLocation.get)
        Feature.add_dependency_relation(
            :requirement,
            ShowEuropeanMap.get,
            ShowCenteredLocation.get)
        Feature.add_dependency_relation(
            :requirement,
            ShowUSAMap.get,
            ShowCenteredLocation.get)
        Feature.add_dependency_relation(
            :requirement,
            InformEuropeanEmergencyCall.get,
            InformGeneralInstructions.get)
        Feature.add_dependency_relation(
            :requirement,
            InformUSAEmergencyCall.get,
            InformGeneralInstructions.get)
        Feature.add_dependency_relation(
            :requirement,
            InformEmergencies.get,
            AlertEmergencies.get)

        # causality
        Feature.add_dependency_relation(
            :causality,
            ShowMap.get,
            ShowCenteredLocation.get)
        Feature.add_dependency_relation(
            :causality,
            ShowMap.get,
            ShowOnMap.get)
        Feature.add_dependency_relation(
            :causality,
            ShowOnMap.get,
            ShowUserOnMap.get)
        Feature.add_dependency_relation(
            :causality,
            InformEmergencies.get,
            GuideUser.get)
        # (missing causality from thesis)
        Feature.add_dependency_relation(
            :causality,
            InformGeneralInstructions.get,
            InformUSAEmergencyCall.get)

        # implication
        Feature.add_dependency_relation(
            :implication,
            Feature.default,
            InformGeneralInstructions.get)
        Feature.add_dependency_relation(
            :implication,
            ShowBelgianMap.get,
            ShowEuropeanMap.get)
        Feature.add_dependency_relation(
            :implication,
            InformAndAlertEmergencies.get,
            InformEmergencies.get)
        Feature.add_dependency_relation(
            :implication,
            InformAndAlertEmergencies.get,
            AlertEmergencies.get)
        Feature.add_dependency_relation(
            :implication,
            GuideUser.get,
            InformGuidance.get)
        # (missing implication from thesis)
        Feature.add_dependency_relation(
            :implication,
            InformGeneralInstructions.get,
            InformUser.get)

        # conjunction
        Feature.add_dependency_relation(
            :conjunction,
            ShowEmergenciesOnMap.get,
            ShowOnMap.get,
            InformEmergencies.get)
        Feature.add_dependency_relation(
            :conjunction,
            ShowSafePlacesOnMap.get,
            ShowOnMap.get,
            InformSafePlaces.get)
        Feature.add_dependency_relation(
            :conjunction,
            ShowGuidanceOnMap.get,
            ShowOnMap.get,
            GuideUser.get)
        Feature.add_dependency_relation(
            :conjunction,
            GuideOutOfDanger.get,
            GuideUser.get,
            AlertInDanger.get)
        Feature.add_dependency_relation(
            :conjunction,
            GuideToSafety.get,
            GuideUser.get,
            InformSafePlaces.get)
        Feature.add_dependency_relation(
            :conjunction,
            GuideToSafetyWithDangerAvoidance.get,
            GuideOutOfDanger.get,
            GuideToSafety.get)

        # disjunction
        Feature.add_dependency_relation(
            :disjunction,
            AlertUser.get,
            AlertEmergencies.get,
            AlertInDanger.get)
    end

    def configuration_relations
        # FDEFAULT-related
        Feature.add_configuration_relation(
            :mandatory,
            Feature.default,
            InformUser.get)
        Feature.add_configuration_relation(
            :optional,
            Feature.default,
            AlertUser.get)
        Feature.add_configuration_relation(
            :optional,
            Feature.default,
            ShowMap.get)
        Feature.add_configuration_relation(
            :optional,
            Feature.default,
            GuideUser.get)

        # INFORM-related
        Feature.add_configuration_relation(
            :mandatory,
            InformUser.get,
            InformGeneralInstructions.get)
        Feature.add_configuration_relation(
            :optional,
            InformUser.get,
            InformEmergencies.get)
        Feature.add_configuration_relation(
            :optional,
            InformUser.get,
            InformSafePlaces.get)
        Feature.add_configuration_relation(
            :optional,
            InformUser.get,
            InformGuidance.get)
        Feature.add_configuration_relation(
            :alternative,
            InformGeneralInstructions.get,
            InformUSAEmergencyCall.get,
            InformEuropeanEmergencyCall.get)

        # ALERT-related
        Feature.add_configuration_relation(
            :or,
            AlertUser.get,
            AlertEmergencies.get,
            AlertInDanger.get)

        # SHOW-related
        Feature.add_configuration_relation(
            :optional,
            ShowMap.get,
            ShowCenteredLocation.get)
        Feature.add_configuration_relation(
            :optional,
            ShowMap.get,
            ShowOnMap.get)
        Feature.add_configuration_relation(
            :alternative,
            ShowCenteredLocation.get,
            ShowUSAMap.get,
            ShowEuropeanMap.get)
        Feature.add_configuration_relation(
            :optional,
            ShowEuropeanMap.get,
            ShowBelgianMap.get)
        Feature.add_configuration_relation(
            :mandatory,
            ShowOnMap.get,
            ShowUserOnMap.get)
        Feature.add_configuration_relation(
            :optional,
            ShowOnMap.get,
            ShowEmergenciesOnMap.get)
        Feature.add_configuration_relation(
            :optional,
            ShowOnMap.get,
            ShowSafePlacesOnMap.get)
        Feature.add_configuration_relation(
            :optional,
            ShowOnMap.get,
            ShowGuidanceOnMap.get)

        # GUIDE-related
        Feature.add_configuration_relation(
            :optional,
            GuideUser.get,
            GuideOutOfDanger.get)
        Feature.add_configuration_relation(
            :optional,
            GuideUser.get,
            GuideToSafety.get)
        Feature.add_configuration_relation(
            :optional,
            GuideUser.get,
            GuideToSafetyWithDangerAvoidance.get)

        # additional
        Feature.add_configuration_relation(
            :additional,
            [   :implication,
                InformGuidance.get,
                GuideUser.get])
        Feature.add_configuration_relation(
            :additional,
            [   :implication,
                AlertEmergencies.get,
                InformEmergencies.get])
        Feature.add_configuration_relation(
            :additional,
            [   :implication,
                ShowEmergenciesOnMap.get,
                [   :conjunction,
                    ShowOnMap.get,
                    InformEmergencies.get]])
        Feature.add_configuration_relation(
            :additional,
            [   :implication,
                ShowSafePlacesOnMap.get,
                [   :conjunction,
                    ShowMap.get,
                    InformSafePlaces.get]])
        Feature.add_configuration_relation(
            :additional,
            [   :implication,
                ShowGuidanceOnMap.get,
                [   :conjunction,
                    ShowMap.get,
                    GuideUser.get]])
        Feature.add_configuration_relation(
            :additional,
            [   :implication,
                GuideOutOfDanger.get,
                [   :conjunction,
                    GuideUser.get,
                    AlertInDanger.get]])
        Feature.add_configuration_relation(
            :additional,
            [   :implication,
                GuideToSafety.get,
                [   :conjunction,
                    GuideUser.get,
                    InformSafePlaces.get]])
        Feature.add_configuration_relation(
            :additional,
            [   :implication,
                GuideToSafetyWithDangerAvoidance.get,
                [   :conjunction,
                    GuideOutOfDanger.get,
                    GuideToSafety.get]])
    end

end

InitFeatures.instance