# Copyright (C) 2015 TopCoder Inc., All Rights Reserved.
#
# DemoController has all methods to authorize, unauthorize and call the EnPhase APIs.
# Includes DemoHelperMethods which includes data persisting methods to db.
# 
#  
# Author: TCSASSEMBLER
# Version: 1.0

require "demo_helper_methods.rb"

class DemoController < ApplicationController
  include DemoHelperMethods

  SUCCESS_RESPONSE = 200
  ENPHASE_AUTH_URL = YAML.load_file(File.join(Rails.root, 'config', 'enphase_authorize_url.yml'))
  
  before_filter :set_enphase_user_id

  # This method redirects the app to Enlighten Enphase auth page.
  # 
  # We specify redirect params so that app redirects back to the app after authorization.
  def authorize
    redirect_to ENPHASE_AUTH_URL[Rails.env]
  end

  # This is the callback method passed in the above redirect URL and retrives the enphase_user_id.
  # 
  # This method stores the authorized user to the user table.
  # 
  # Also, this method sets the cookie value so that the session is persisted until unauthorized.
  def callback
    user = User.find_or_create_by_enphase_user_id(params[:user_id])
    cookies[:enphase_user_id] = { :value => params[:user_id] }
    set_enphase_user_id

    redirect_to demo_index_path
  end

  # This method unauthorizes the EnPhase user by resetting the cookie.
  def unauthorize
    cookies.delete :enphase_user_id

    redirect_to demo_index_path
  end

  # This method calls get_enphase_feed with the summary date param.
  # 
  # On succesful response, the data returned, the total time taken for the job are persisted to db.
  # 
  # Returns JSON response of the API.
  def get_enphase_feed
    rescue_from_error do
      Enphase.get_enphase_feed(@user_id, params[:system_id], 
        { :summary_date => params[:summary_date] }) 
    end

    if @response and @response.status == SUCCESS_RESPONSE
      build_data_harvest(@start_time, @end_time, @response)
      total_end_time = Time.now.to_f
      build_job(@start_time, total_end_time)
    end

    respond_to do |format|
      format.json { render json: @response.to_json }
    end
  end

  # This method calls get_enphase_summary.
  # 
  # On succesful response, the summary data returned, the total time taken for the job 
  # are persisted to db.
  # 
  # Returns JSON response of the API
  def get_enphase_summary
    rescue_from_error { Enphase.get_enphase_summary(@user_id, params[:system_id]) }
    
    if @response and @response.status == SUCCESS_RESPONSE
      build_summary_data(@start_time, @end_time, @response)
    end

    respond_to do |format|
      format.json { render json: @response.to_json }
    end
  end

  # This method calls get_enphase_last_7_day_summaries.
  # 
  # On succesful response, the summary data returned, the total time taken for the job 
  # are persisted to db.
  # 
  # Returns JSON response of the API
  def get_enphase_last_7_day_summaries
    rescue_from_error { Enphase.get_enphase_last_7_day_summaries(@user_id, params[:system_id]) }
    @start_time = Time.now.to_f
    
    total_end_time = Time.now.to_f
    build_job(@start_time, total_end_time)
    
    respond_to do |format|
      format.json { render json: @response.to_json }
    end
  end

  # This method calls the stats APi - get_enphase_today_stats which returns today's stats.
  # 
  # On succesful response, the stats data returned, the total time taken for the job 
  # are persisted to db.
  # 
  # Returns JSON response of the API
  def get_enphase_today_stats
    rescue_from_error { Enphase.get_enphase_today_stats(@user_id, params[:system_id]) }
    
    if @response and @response.status == SUCCESS_RESPONSE
      build_stats_data(@start_time, @end_time, @response)
    end

    respond_to do |format|
      format.json { render json: @response.to_json }
    end
  end

  # This method calls the stats API - get_enphase_today_stats which returns last 7 days' stats.
  # 
  # On succesful response, the stats data returned, the total time taken for the job 
  # are persisted to db.
  # 
  # Returns JSON response of the API
  def get_enphase_last_7_day_stats
    rescue_from_error { Enphase.get_enphase_last_7_day_stats(@user_id, params[:system_id]) }    
  
    if @response and @response.status == SUCCESS_RESPONSE
      build_stats_data(@start_time, @end_time, @response)
    end

    respond_to do |format|
      format.json { render json: @response.to_json }
    end
  end

  # This method calls the stats API - get_enphase_historical_stats with start_at and end_at 
  # unix epoch times.
  # 
  # On succesful response, the stats data returned, the total time taken for the job 
  # are persisted to db.
  # 
  # Returns JSON response of the API
  def get_enphase_historical_stats
    rescue_from_error do
      data = { :start_at => params[:start_at], :end_at => params[:end_at] }
      Enphase.get_enphase_historical_stats(@user_id, params[:system_id], data)
    end

    if @response and @response.status == SUCCESS_RESPONSE
      build_stats_data(@start_time, @end_time, @response)
    end

    respond_to do |format|
      format.json { render json: @response.to_json }
    end
  end

  # This method calls the get_enphase_energy_lifetime API.
  # 
  # On succesful response, the energy data returned, the total time taken for the job 
  # are persisted to db.
  # 
  # Returns JSON response of the API
  def get_enphase_energy_lifetime
    rescue_from_error { Enphase.get_enphase_energy_lifetime(@user_id, params[:system_id]) }

    if @response and @response.status == SUCCESS_RESPONSE
      build_enphase_energy_data(@start_time, @end_time, @response)
    end

    respond_to do |format|
      format.json { render json: @response.to_json }
    end
  end

  def index    
  end

  private
    # This method retrieves the enphase_user_id to be passed to the API from the cookie.
    # 
    # For demo purposes, enphase_user_id "4d7a45774e6a41320a" is used.
    # 
    # But, the this has to be replaced by the commented line below to actually get the 
    # user_id from the cookie.
    def set_enphase_user_id
      @user_id = cookies[:enphase_user_id].blank? ? nil : "4d7a45774e6a41320a"
      # @user_id = cookies[:enphase_user_id].blank? ? nil : cookies[:enphase_user_id]
    end

    # This method captures the time before and after the API execution and is later stored in the db.
    # 
    # Also, rescues any abnormal error on execution and logs the exception.
    def rescue_from_error
      begin
        @start_time = Time.now.to_f
        @response = yield
        @end_time = Time.now.to_f
      rescue Exception => e
        logger.debug "Exception - #{e}"
      end
    end

end
