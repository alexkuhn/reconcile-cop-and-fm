#!/usr/bin/env ruby

class ERSSafePlace

    attr_accessor :name
    attr_accessor :properties

    def initialize(name)
        @properties = {}
        if name == :ucl
            initialize_ucl
        else # :uzleuven
            initialize_uzleuven
        end
    end

    def initialize_ucl
        @name = "Catholic University of Louvain"
        @properties[:Address] = "Place de l'Unversité 1, 1348 Louvain-la-Neuve"
        @properties[:Type] = :school
    end

    def initialize_uzleuven
        @name = "UZ Leuven"
        @properties[:Address] = "Herestraat 49, 3000 Leuven"
        @properties[:Type] = :hospital
    end

end
