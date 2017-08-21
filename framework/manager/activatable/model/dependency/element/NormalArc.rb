#!/usr/bin/env ruby

require_relative 'Arc'

class NormalArc < Arc

    attr_accessor :weight

    def initialize(category, input_node, output_node, weight=1)
        super(category, input_node, output_node)
        @type   = :normal_arc
        @weight = weight
    end

    def to_s
        "#{super}weight: #{@weight}\n"
    end

end
