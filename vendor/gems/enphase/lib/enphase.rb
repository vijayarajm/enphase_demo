# Copyright (C) 2015 TopCoder Inc., All Rights Reserved.

require "enphase/version"
require "enphase/config"
require "enphase/api_params"
require "enphase/api_wrapper"

require "faraday"
require "active_support/core_ext/time/calculations"

# The main entry of the module. Provides several methods that calls EnPhase API.
# 
# For example:
#   # The following will call get_enphase_summary EnPhase API and returns the enphase summary.
#   require "enphase"
#   response = Enphase.get_enphase_summary("4d7a45774e6a41320a", 67)
#   # => [enphase_summary]
#
# Author: TCSASSEMBLER
# Version: 1.0

module Enphase
  
  # Calls /systems/{system_id}/summary EnPhase API.
  # Accepts enphase_user_id and system_id as input params.
  # Returns JSON response of the API with status, and body
  # 
  # Usage:
  #   require "enphase"
  #   response = Enphase.get_enphase_summary("4d7a45774e6a41320a", 67)
  #   # => [enphase_summary]

  def self.get_enphase_summary(user_id, system_id)
    endpoint = "/systems/#{system_id}/summary"
    query_string = build_query_string(user_id, :get_enphase_summary, {})
    
    Enphase::ApiWrapper.get_response(endpoint, query_string)
  end


  # Calls /systems/{system_id}/summary EnPhase API.
  # Accepts enphase_user_id, system_id and summary_date as input params.
  # Returns JSON response of the API with status, and body
  # 
  # Usage:
  #   require "enphase"
  #   response = Enphase.get_enphase_feed("4d7a45774e6a41320a", 67, {:summary_date => "2015-01-02"})
  #   # => [enphase_summary]

  def self.get_enphase_feed(user_id, system_id, params)
    endpoint = "/systems/#{system_id}/summary"
    query_string = build_query_string(user_id, :get_enphase_feed, params)
    
    Enphase::ApiWrapper.get_response(endpoint, query_string)
  end


  # Calls /systems/{system_id}/summary EnPhase API.
  # Accepts enphase_user_id and system_id as input params.
  # Returns total energy value of summaries with API response status
  # 
  # Usage:
  #   require "enphase"
  #   response = Enphase.get_enphase_last_7_day_summaries("4d7a45774e6a41320a", 67)

  def self.get_enphase_last_7_day_summaries(user_id, system_id)
    result = []
    total_value = 0
    (1..7).each do |i|
      @response = get_enphase_feed(user_id, system_id, { :summary_date => i.days.ago.strftime("%Y-%m-%d") })
      if @response.status == 200
        body_json = JSON.parse(@response.body)
        total_value += body_json['energy_today'] 
      else
        return @response
      end
    end
    
    # Check with client on what all additional data to be sent. 
    { :status => @response.status, :body => { :total_energy_value => total_value }}
  end


  # Calls /systems/{system_id}/stats EnPhase API.
  # Accepts enphase_user_id and system_id as input params.
  # Returns JSON response of the API with status, and body
  # 
  # Usage:
  #   require "enphase"
  #   response = Enphase.get_enphase_last_7_day_stats("4d7a45774e6a41320a", 67)
  #   # => [enphase_stat]

  def self.get_enphase_last_7_day_stats(user_id, system_id)
    params = { :start_at => 7.days.ago.beginning_of_day.to_i.to_s, 
      :end_at => 1.days.ago.end_of_day.to_i.to_s }
    get_enphase_stats(user_id, system_id, params)
  end


  # Calls /systems/{system_id}/stats EnPhase API.
  # Accepts enphase_user_id and system_id as input params.
  # Returns JSON response of the API with status, and body
  # 
  # Usage:
  #   require "enphase"
  #   response = Enphase.get_enphase_today_stats("4d7a45774e6a41320a", 67)
  #   # => [enphase_stat]

  def self.get_enphase_today_stats(user_id, system_id)
    params = { :start_at => 1.days.ago.beginning_of_day.to_i.to_s, 
      :end_at => Time.now.to_i.to_s }
    get_enphase_stats(user_id, system_id, params)
  end


  # Calls /systems/{system_id}/stats EnPhase API.
  # Accepts enphase_user_id, system_id, start_at and end_at as input params.
  # start_at and end_at should be in unix epoch seconds format.
  # Returns JSON response of the API with status, and body
  # 
  # Usage:
  #   require "enphase"
  #   response = Enphase.get_enphase_historical_stats("4d7a45774e6a41320a", 67, 
  #                       { :start_at => "1411822918" , :end_at => "1414414914" })
  #   # => [enphase_stat]

  def self.get_enphase_historical_stats(user_id, system_id, params)
    get_enphase_stats(user_id, system_id, params)
  end  


  # Calls /systems/{system_id}/energy_lifetime EnPhase API.
  # Accepts enphase_user_id, system_id and summary_date as input params.
  # Returns JSON response of the API with status, and body
  # 
  # Usage:
  #   require "enphase"
  #   response = Enphase.get_enphase_energy_lifetime("4d7a45774e6a41320a", 67)
  #   # => [enphase_energy_lifetime_daily_readings]

  def self.get_enphase_energy_lifetime(user_id, system_id)
    endpoint = "/systems/#{system_id}/energy_lifetime"
    query_string = build_query_string(user_id, :get_enphase_energy_lifetime)

    Enphase::ApiWrapper.get_response(endpoint, query_string)
  end

  private
    # Builds query string with the input params, API key and enphase_user_id values.
    def self.build_query_string(user_id, api_method, params = {})
      query_string = Enphase::ApiParams.construct_query_string(api_method, params)
      "#{query_string}key=#{Enphase::Config::KEY}&user_id=#{user_id}"
    end

    # This methods wraps /systems/{system_id}/stats EnPhase API and is used for retrieving today's stats,
    # last 7 days' stats and historical stats.
    def self.get_enphase_stats(user_id, system_id, params)
      endpoint = "/systems/#{system_id}/stats"
      query_string = build_query_string(user_id, :get_enphase_stats, params)
      
      Enphase::ApiWrapper.get_response(endpoint, query_string)
    end
  
end
