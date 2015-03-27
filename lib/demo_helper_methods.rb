# Copyright (C) 2015 TopCoder Inc., All Rights Reserved.
# 
# This file includes helper methods to persists API response data to the database.
#
# Author TCSASSEMBLER
# Version 1.0

module DemoHelperMethods

  # This method builds stats, data_harvest and job.
  # Accepts start_time, end_time, response as parameters.
  def build_stats_data(start_time, end_time, response)
    body_json = JSON.parse(@response.body)
    body_json['intervals'].each { |stat| build_enphase_stats(body_json, stat) }
    build_data_harvest(start_time, end_time, @response)
    
    total_end_time = Time.now.to_f
    build_job(start_time, total_end_time)
  end

  # This method builds summary, data_harvest and job data.
  # Accepts start_time, end_time, response as parameters.
  def build_summary_data(start_time, end_time, response)
    build_enphase_summary(response.body) 
    build_data_harvest(start_time, end_time, response)
    
    total_end_time = Time.now.to_f
    build_job(start_time, total_end_time)
  end

  # This method builds enphase_energy_data.
  # Accepts start_time, end_time, response as parameters.
  def build_enphase_energy_data(start_time, end_time, response)
    body_json = JSON.parse(response.body)
    eel = build_enphase_energy_lifetime(body_json)    
    build_enphase_energy_lifetime_daily_readings(eel, body_json)
    build_data_harvest(start_time, end_time, response)
    
    total_end_time = Time.now.to_f
    build_job(start_time, total_end_time)
  end
  
  # This method builds data_harvest data
  # Accepts start_time, end_time, response as parameters.
  def build_data_harvest(start_time, end_time, response)
    response_hash = response.to_hash
    DataHarvest.create(
      :harvest_start_time => start_time, 
      :harvest_end_time => end_time, 
      :url => response_hash[:url].to_s, 
      :raw_data => response.body
    )
  end

  # This method builds the job data and stores time parameters.
  # Accepts start_time, end_time as parameters.
  def build_job(start_time, end_time)
    Job.create(
      :start_time => start_time, 
      :end_time => end_time, 
      :running_time => (end_time-start_time), 
      :name => action_name
    )
  end

  # This method builds enphase summary data.
  # 
  # Accepts API response body as input param.
  def build_enphase_summary(summary)
    summary = JSON.parse(summary)
    EnphaseSummary.create(
      :enphase_user_id => @user_id, 
      :energy_lifetime => summary["energy_lifetime"], 
      :energy_today => summary["energy_today"], 
      :operational_at => summary["operational_at"], 
      :size_w => summary["size_w"]
    )
  end

  # This method builds enphase stats data.
  # Accepts API response body as input param.
  def build_enphase_stats(body_json, stat)
    EnphaseStat.create(
      :enphase_user_id => @user_id,
      :system_id => body_json["system_id"], 
      :enwh => stat["enwh"], 
      :end_at => stat["end_at"]
    )
  end

  # This method builds enphase energy data.
  # Accepts API response body as input param.
  def build_enphase_energy_lifetime(body_json)
    EnphaseEnergyLifetime.create(
      :enphase_user_id => @user_id,
      :system_id => body_json["system_id"],
      :start_date => body_json["start_date"]
    )
  end

  # This method builds enphase_energy_lifetime_daily_readings data.
  # Accepts enphase_energy_lifetime object and response body as params
  def build_enphase_energy_lifetime_daily_readings(eel, body_json)
    values = []

    body_json["production"].each_with_index do |stat, i|
      values << [ 
        :enphase_user_id => @user_id, 
        :system_id => body_json["system_id"], 
        :production_enwh => stat, 
        :est_date => (Date.parse(body_json["start_date"]) + (i+1)) 
      ]
    end

    eel.enphase_energy_lifetime_daily_readings.create!(values)
  end
end