#!/usr/bin/env ruby

require_relative 'Arc'

class InhibitorArc < Arc

    def initialize(category, input_node, output_node)
        check_valid_nodes(input_node, output_node)
        super(category, input_node, output_node)
        @type = :inhibitor_arc
    end

    def check_valid_nodes(input_node, output_node)
        if input_node.node_type == :transition
            raise Exception.new('cannot create an inhibitor arc with a transition as input node')
        elsif output_node.node_type == :place
            raise Exception.new('cannot create an inhibitor arc with a place as output node')
        end
    end

    def to_s
        "#{super}"
    end

end
