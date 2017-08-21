#!/usr/bin/env ruby

require_relative 'APNAlgorithm'

class AddConjunction < APNAlgorithm

    def apply_ext(activatables)
        p = activatables.at(0)
        c = activatables[1..activatables.length]

        added_elements = Array.new

        # t1
        it_1 = InternalTransition.new(:dependency, p, :activation)
        added_elements << it_1

        # t2
        it_2 = InternalTransition.new(:dependency, p, :deactivation)
        added_elements << it_2

        # c[i] --> t1
        #   t1 --> c[i] 
        @apn.elements.each do |e|
            if e.type == :activatable_place and c.include?(e.activatable)
                added_elements << NormalArc.new(:dependency, e, it_1)
                added_elements << NormalArc.new(:dependency, it_1, e)
            end
        end

        # t1 --> p
        # p --o t1
        # p --o t2
        @apn.elements.each do |e|
            if e.type == :activatable_place and e.activatable == p
                added_elements << NormalArc.new(:dependency, it_1, e)
                added_elements << InhibitorArc.new(:dependency, e, it_1)
                added_elements << InhibitorArc.new(:dependency, e, it_2)
            end
        end

        # pr(!p) --> t2
        @apn.elements.each do |e|
            if e.type == :temporary_place and e.activatable == p and e.active_state == :deactivation
                added_elements << NormalArc.new(:dependency, e, it_2)
            end
        end

        @apn.elements.concat(added_elements)
    end

    def apply_cons(activatables)
        p = activatables.at(0)
        c = activatables[1..activatables.length]

        added_elements = Array.new

        # pr(!p)
        tp_deac_p = @apn.elements.find do |e|
            e.type == :temporary_place and e.activatable == p and e.active_state == :deactivation
        end

        c.each do |ci|
            # c[i]
            ap_ci = @apn.elements.find do |e|
                e.type == :activatable_place and e.activatable == ci
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
