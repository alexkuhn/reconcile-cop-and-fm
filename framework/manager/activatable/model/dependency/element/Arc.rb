#!/usr/bin/env ruby

require_relative 'Element'

class Arc < Element

    attr_accessor :input_node
    attr_accessor :output_node

    def initialize(category, input_node, output_node)
        super(category)
        
        check_valid_nodes(input_node, output_node)

        @input_node  = input_node
        @output_node = output_node

        @input_node.add_output_arc(self)
        @output_node.add_input_arc(self)

        @type = :arc
    end

    def check_valid_nodes(input_node, output_node)
        if input_node.node_type == :place
            if output_node.node_type == :place
                raise Exception.new('cannot create an arc between two places')
            end
        elsif input_node.node_type == :transition
            if output_node.node_type == :transition
                raise Exception.new('cannot create an arc between two transitions')
            end
        end
    end

    def remove_connectors
        @input_node.remove_output_arc(self)
        @output_node.remove_input_arc(self)
        @input_node = nil
        @output_node = nil
    end

    def to_s
        "#{super}input_node_id: #{@input_node.id}\noutput_node_id: #{@output_node.id}\n"
    end

end
