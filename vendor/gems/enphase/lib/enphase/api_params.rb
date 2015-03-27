# Copyright (C) 2015 TopCoder Inc., All Rights Reserved.
# 
# This module performs basic validations on input params of EnPhase API.
# Also, this method constructs the query string to be used in the requests.
# 
# Author: TCSASSEMBLER
# Version: 1.0

module Enphase
  module ApiParams

    # This constant defines the required params of the respective API methods.
    PARAM_MAPPINGS = {
      :get_enphase_summary => [],
      :get_enphase_feed => [:summary_date],
      :get_enphase_stats => [:start_at, :end_at],
      :get_enphase_energy_lifetime => [],
      :get_enphase_historical_stats => [:start_at, :end_at]
    }

    # Builds the query string with the API method and the given params.
    # Raises ArgumentError if required params are missing.
    # Returns theconstructed query string.
    def self.construct_query_string(api_method, params)
      missing_params = check_for_exceptions(api_method, params)
      unless missing_params.empty?
        raise ArgumentError, %(Following param(s) are missing - #{missing_params}) 
      end

      PARAM_MAPPINGS[api_method].map {|attribute| %(#{attribute}=#{params[attribute]}&) }.join("")
    end

    private
      # This method uses PARAM_MAPPINGS constants and returns the missing mandatory params.
      # Accepts API method and the params as input.
      def self.check_for_exceptions(api_method, params)
        missing_params = []
        PARAM_MAPPINGS[api_method].each do |param|          
          missing_params << param unless params.keys.include?(param)
        end
        missing_params
      end
  end
end