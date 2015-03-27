# Copyright (C) 2015 TopCoder Inc., All Rights Reserved.
# 
# This module has several examples to test negative use cases of EnPhase API.
# 
# Author: TCSASSEMBLER
# Version: 1.0

require 'spec_helper'

describe Enphase do

  SAMPLE_USER_ID = "4d7a45774e6a41320a"

  INVALID_USER_ID = "nwde3foifc"
  INVALID_SYSTEM_ID = "111"

  before(:each) do
    sleep(10)
  end

  it 'has a version number' do
    expect(Enphase::VERSION).not_to be nil
  end

  it 'calls get_enphase_summary API' do
    response = Enphase.get_enphase_summary(INVALID_USER_ID, INVALID_SYSTEM_ID)
    response.status.should_not eql 200
  end

  it 'calls get_enphase_feed API' do
    response = Enphase.get_enphase_feed(SAMPLE_USER_ID, 
            INVALID_SYSTEM_ID, {:summary_date => "2015-01-02"})
    response.status.should_not eql 200
  end

  it 'calls get_enphase_last_7_day_summaries API' do
    response = Enphase.get_enphase_last_7_day_summaries(INVALID_USER_ID, INVALID_SYSTEM_ID)
    response.status.should_not eql 200
  end

  it 'calls get_enphase_last_7_day_stats API' do
    response = Enphase.get_enphase_last_7_day_stats(SAMPLE_USER_ID, INVALID_SYSTEM_ID)
    response.status.should_not eql 200
  end

  it 'calls get_enphase_today_stats API' do
    response = Enphase.get_enphase_today_stats(INVALID_USER_ID, INVALID_SYSTEM_ID)
    response.status.should_not eql 200
  end

  it 'calls get_enphase_historical_stats API' do
    response = Enphase.get_enphase_historical_stats(INVALID_USER_ID, 
      INVALID_SYSTEM_ID, { :start_at => "1411822918" , :end_at => "1414414914" })
    response.status.should_not eql 200
  end

  it 'calls get_enphase_energy_lifetime API' do
    response = Enphase.get_enphase_energy_lifetime(INVALID_USER_ID, INVALID_SYSTEM_ID)
    response.status.should_not eql 200
  end
  
end
