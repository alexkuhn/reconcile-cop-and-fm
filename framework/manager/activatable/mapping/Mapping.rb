#!/usr/bin/env ruby

require_relative 'MappedFeature'

class Mapping

    attr_accessor :mapped_features

    def initialize
		@mapped_features = []
	end

    def add_mapping(type, context, feature)
        check_type(type)
        check_context(context)
        check_feature(feature)
        register_mapping(type, context, feature)
    end

    def check_type(type)
        if type != :enabler and type != :disabler
            raise_exception(:invalid_type_error, type)
        end
    end

    def check_context(context)
        if context.type != :context
            self.raise_exception(:not_context_error, context)
        end
    end

    def check_feature(feature)
        if feature.type != :feature
            self.raise_exception(:not_feature_error, feature)
        end
    end

    def raise_exception(exception_type, *elements)
        error_string = ""
        if exception_type == :invalid_type_exception
            type   = elements[0]
            error_string  = "Unhandled mapping of type #{type}:"
            error_string += " neither ':enabler' nor ':disabler'}"
        elsif exception_type == :not_context_error
            activatable = elements[0]
            error_string  = "#{activatable} is not a context,"
            error_string += " although it should be!'}"
        elsif exception_type == :not_feature_error
            activatable = elements[0]
            error_string  = "#{activatable} is not a feature,"
            error_string += " although it should be!'}"
        end
        raise Exception.new(error_string)
    end

    def register_mapping(type, context, feature)
        m = nil
        m = find_mapped_feature(feature)
        if m.nil?
            m = MappedFeature.new(feature)
            @mapped_features << m
        end
        m.add(type, context)
    end

    def find_mapped_feature(feature)
        @mapped_features.find do |m|
            m.activatable.name == feature.name
        end
    end

    def select_features
        requests = {
            :activation   => [],
            :deactivation => []}
        @mapped_features.each do |m|
            req = m.select_feature
            if not req.nil?
                append_request(requests, req)
            end
        end
        requests
    end

    def append_request(requests, req)
        req.each do |req_type, req_acts|
            if requests[req_type].nil?
                requests[req_type] = []
            end
            req_acts.each do |act|
                requests[req_type] << act
            end
        end
    end

end
