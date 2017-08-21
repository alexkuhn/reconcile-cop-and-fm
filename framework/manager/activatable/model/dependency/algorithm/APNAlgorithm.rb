#!/usr/bin/env ruby

require_relative '../element/ActivatablePlace'
require_relative '../element/TemporaryPlace'
require_relative '../element/InternalTransition'
require_relative '../element/ExternalTransition'
require_relative '../element/NormalArc'
require_relative '../element/InhibitorArc'

class APNAlgorithm

    attr_accessor :apn

    def initialize(apn)
        @apn = apn
    end

    def apply_ext
    end

    def apply_cons
    end

end