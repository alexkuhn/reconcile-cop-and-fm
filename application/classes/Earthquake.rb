#!/usr/bin/env ruby

require_relative 'Emergency'

class Earthquake < Emergency

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
