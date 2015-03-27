# Copyright (C) 2015 TopCoder Inc., All Rights Reserved.
# This file has test cases to check the authorization process.
# 
# Checks if the session is stored in the cookies, checks if user is added if authorized.
# Also checks unauthorization flow
#
# Author: TCSASSEMBLER
# Version: 1.0

require 'rails_helper'

describe DemoController do
	SAMPLE_USER_ID = "4d7a45774e6a41320a"

	it "should authorize with the user" do
	  post 'authorize'
	  
	  response.body.should =~ /redirected/
	end

	it "should create an user after authorization" do
	  post 'callback', { :user_id => SAMPLE_USER_ID }

	  user_id = cookies[:enphase_user_id]
	  user_id.should be_eql SAMPLE_USER_ID
	  
	  user = User.find_by_enphase_user_id(SAMPLE_USER_ID)
	  user.should_not be_nil
	end

	it "should clear the cookie after unauthorization" do
	  post "unauthorize"

	  user_id = cookies[:enphase_user_id]
	  user_id.should be_nil
	end
end
