#!/usr/bin/env ruby

require_relative 'APNAlgorithm'

class AddDisjunction < APNAlgorithm

    def apply_ext(activatables)
        # none
    end

    def apply_cons(activatables)
        p = activatables.at(0)
        c = activatables[1..activatables.length]

        added_elements = Array.new

        # pr(p)
        tp_act_p = @apn.elements.find do |e|
            e.type == :temporary_place and e.activatable == p and e.active_state == :activation
        end

        # pr(!p)
        tp_deac_p = @apn.elements.find do |e|
            e.type == :temporary_place and e.activatable == p and e.active_state == :deactivation
        end

        c.each do |ci|
            # c[i]
            ap_ci = @apn.elements.find do |e|
                e.type == :activatable_place and e.activatable == ci
            end
            # act(c[i]) --> pr(p)
            @apn.elements.each do |e|
                if e.type == :internal_transition
                    if not e.input_normal_nodes.include?(ap_ci)
                        if e.output_normal_nodes.include?(ap_ci)
                            added_elements << NormalArc.new(:dependency, e, tp_act_p)
                        end
                    end
                end
            end
            # deac(c[i]) --> pr(!p)
            @apn.elements.each do |e|
                if e.type == :internal_transition
                    if e.input_normal_nodes.include?(ap_ci)
                        if not e.output_normal_nodes.include?(ap_ci)
                            added_elements << NormalArc.new(:dependency, e, tp_deac_p)
                        end
                    end
                end
            end    
        end

        @apn.elements.concat(added_elements)

    end

end
