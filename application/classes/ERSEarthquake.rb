#!/usr/bin/env ruby

require_relative 'ERSEmergency'

class ERSEarthquake < ERSEmergency

    def initialize(epicenter=nil, magnitude=nil, radius=nil)
        super()
        @type = :earthquake

        if epicenter.nil?
            epicenter = "Place de la Bourse, 1000 Bruxelles"
        end
        if magnitude.nil?
            magnitude = 3.2
        end
        if radius.nil?
            radius = "25km"
        end
        @properties[:epicenter] = epicenter
        @properties[:magnitude] = magnitude
        @properties[:radius] = radius
    end

end
