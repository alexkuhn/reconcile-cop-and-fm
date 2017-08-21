#!/usr/bin/env ruby

require_relative 'ERSEmergency'

class ERSWildfire < ERSEmergency

    def initialize(location=nil, severity=nil)
        super()
        @type = :Wildfire

        if location.nil?
            location = "Boulevard de l'Europe 100, 1300 Wavre"
        end
        if severity.nil?
            severity = :high
        end
        @properties[:Location] = location
        @properties[:Severity] = severity
    end

end
