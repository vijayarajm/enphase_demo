# Copyright (C) 2015 TopCoder Inc., All Rights Reserved.
# This file has test cases to check the negative cases of the Demo Controller methods
# 
# A number of examples with invalid user_id, invalid system_id and other invalid args are checked.
#
# Author: TCSASSEMBLER
# Version: 1.0

require 'rails_helper'

describe DemoController do
  SAMPLE_USER_ID = "4d7a45774e6a41320a"
  INVALID_SYSTEM_ID = "ncvuierv"

  before(:each) do
    sleep(5)
    request.cookies[:enphase_user_id] = { :value => SAMPLE_USER_ID }
    request.env["HTTP_ACCEPT"] = "application/json"
  end

  # Next 3 examples checks 401 responses when enphase_user_id is absent or invalid.
  it "should return 401 when user_id is invalid get_enphase_feed" do
    request.cookies.delete :enphase_user_id
    post 'get_enphase_feed', { :system_id => INVALID_SYSTEM_ID, :summary_date => "2015-01-02" }

    @api_response = JSON.parse(response.body)
    @api_response["status"].should be_eql 401  
  end

  it "should return 401 when user_id is invalid for get_enphase_today_stats" do
    request.cookies.delete :enphase_user_id
    post 'get_enphase_today_stats', { :system_id => INVALID_SYSTEM_ID }

    @api_response = JSON.parse(response.body)
    @api_response["status"].should be_eql 401  
  end

  it "should return 401 when user_id is invalid for get_enphase_historical_stats" do
    request.cookies.delete :enphase_user_id
    post 'get_enphase_historical_stats', { :system_id => INVALID_SYSTEM_ID }

    @api_response = JSON.parse(response.body)
    @api_response["status"].should be_eql 401  
  end

  # Next 3 examples checks for 404 responses when an ID of a non existing System in get_enphase_summary
  it "should return 404 when an ID of a non existing System in get_enphase_summary" do
    post 'get_enphase_feed', { :system_id => INVALID_SYSTEM_ID, :summary_date => "2015-01-02" }

    @api_response = JSON.parse(response.body)
    @api_response["status"].should be_eql 404  
  end

  it "should return 404 when an ID of a non existing System in get_enphase_last_7_day_stats" do
    post 'get_enphase_last_7_day_stats', { :system_id => INVALID_SYSTEM_ID }

    @api_response = JSON.parse(response.body)
    @api_response["status"].should be_eql 404  
  end

  it "should return 404 when an ID of a non existing System in get_enphase_energy_lifetime" do
    post 'get_enphase_energy_lifetime', { :system_id => INVALID_SYSTEM_ID }

    @api_response = JSON.parse(response.body)
    @api_response["status"].should be_eql 404  
  end

  # Next 3 examples checks for argument errors when a mandatory argument is not sent.
  it "should return 404 when an ID of a non existing System in get_enphase_summary" do
    post 'get_enphase_feed', { :system_id => 67, :summary_date => "efniufh34iuh" }
    
    @api_response = JSON.parse(response.body)
    @api_response["status"].should be_eql 422  
  end

  it "should return 404 when an ID of a non existing System in get_enphase_historical_stats" do
    post 'get_enphase_historical_stats', { :system_id => 67, :start_at => "efniufh34iuh", 
      :end_at => "efniufh34iuh" }
    
    @api_response = JSON.parse(response.body)
    @api_response["status"].should be_eql 422  
  end

end