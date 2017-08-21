#!/usr/bin/env ruby

require_relative 'APNAlgorithm'

class AddSingleton < APNAlgorithm

    def apply_ext(activatable)
        # PN nodes
        ap = ActivatablePlace.new(:basic, activatable, :activation)
        tp_act  = TemporaryPlace.new(:basic, activatable, :activation)
        tp_deac = TemporaryPlace.new(:basic, activatable, :deactivation)
        it_act  = InternalTransition.new(:basic, activatable, :activation)
        it_deac = InternalTransition.new(:basic, activatable, :deactivation)
        et_act  = ExternalTransition.new(:basic, activatable, :activation)
        et_deac = ExternalTransition.new(:basic, activatable, :deactivation)
        # PN arcs
        a1 = NormalArc.new(:basic, et_act, tp_act)
        a2 = NormalArc.new(:basic, tp_act, it_act)
        a3 = NormalArc.new(:basic, it_act, ap)
        a4 = NormalArc.new(:basic, et_deac, tp_deac)
        a5 = NormalArc.new(:basic, tp_deac, it_deac)
        a6 = NormalArc.new(:basic, ap, it_deac)
        # store newly created PN elements
        apn.elements.concat([ ap, tp_act, tp_deac, it_act, it_deac, et_act, et_deac, a1, a2, a3, a4, a5, a6 ])
    end

    def apply_cons
        #nothing
    end

end
