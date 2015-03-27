require 'rails_helper'

describe DemoController do

  SAMPLE_USER_ID = "4d7a45774e6a41320a"
  SAMPLE_SYSTEM_ID = 67

  before(:each) do
    sleep(5)
    cookies[:enphase_user_id] = { :value => SAMPLE_USER_ID }
    request.env["HTTP_ACCEPT"] = "application/json"
  end

  after(:each) do
    last_api_job = Job.last.name
    last_data_harvest_url = DataHarvest.last.url

    last_api_job.should be_eql controller.action_name
    last_data_harvest_url.should include(@api_response["url"]["path"])
  end

  it "should respond with 200 OK for get_enphase_feed" do
    post 'get_enphase_feed', { :system_id => SAMPLE_SYSTEM_ID, :summary_date => "2015-01-02" }
    
    @api_response = JSON.parse(response.body)
    @api_response["status"].should be_eql 200  
  end

  it "should respond with 200 OK for get_enphase_summary" do
    post 'get_enphase_summary', { :system_id => SAMPLE_SYSTEM_ID }
    
    @api_response = JSON.parse(response.body)
    @api_response["status"].should be_eql 200
    
    energy_lifetime = JSON.parse(@api_response["body"])["energy_lifetime"]
    summary = EnphaseSummary.find_by_energy_lifetime(energy_lifetime)
    summary.should_not be_nil
  end
  
  it "should respond with 200 OK for get_enphase_last_7_day_summaries" do
    post 'get_enphase_last_7_day_summaries', { :system_id => SAMPLE_SYSTEM_ID }
    
    @api_response = JSON.parse(response.body)
    @api_response["status"].should be_eql 200
  end

  it "should respond with 200 OK for get_enphase_today_stats" do
    post 'get_enphase_today_stats', { :system_id => SAMPLE_SYSTEM_ID }
    p response
    @api_response = JSON.parse(response.body)
    @api_response["status"].should be_eql 200

    intervals = JSON.parse(@api_response["body"])["intervals"]
    intervals.each do |interval|
      EnphaseStat.find_by_enwh(interval["enwh"]).should_not be_nil
    end
  end

  it "should respond with 200 OK for get_enphase_last_7_day_stats" do
    post 'get_enphase_last_7_day_stats', { :system_id => SAMPLE_SYSTEM_ID }
    
    @api_response = JSON.parse(response.body)
    @api_response["status"].should be_eql 200

    intervals = JSON.parse(@api_response["body"])["intervals"]
    intervals.each do |interval|
      EnphaseStat.find_by_enwh(interval["enwh"]).should_not be_nil
    end
  end

  it "should respond with 200 OK for get_enphase_historical_stats" do
    post 'get_enphase_historical_stats', { :system_id => SAMPLE_SYSTEM_ID,
      :start_at => "1411822918", :end_at => "1414414914" }
    
    @api_response = JSON.parse(response.body)
    @api_response["status"].should be_eql 200

    intervals = JSON.parse(@api_response["body"])["intervals"]
    intervals.each do |interval|
      EnphaseStat.find_by_enwh(interval["enwh"]).should_not be_nil
    end
  end

  it "should respond with 200 OK for get_enphase_energy_lifetime" do
    post 'get_enphase_energy_lifetime', { :system_id => SAMPLE_SYSTEM_ID }
    
    @api_response = JSON.parse(response.body)
    @api_response["status"].should be_eql 200

    eel = EnphaseEnergyLifetime.find_by_system_id(SAMPLE_SYSTEM_ID)
    eel.should_not be_nil

    productions = JSON.parse(@api_response["body"])["production"]
    productions.each do |production|
      reading = eel.enphase_energy_lifetime_daily_readings.find_by_production_enwh(production)  
      reading.should_not be_nil
    end
  end

end
