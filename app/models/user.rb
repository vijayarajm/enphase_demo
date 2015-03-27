# Copyright (C) 2015 TopCoder Inc., All Rights Reserved.
# 
# This file represents the USer model.
#
# Author TCSASSEMBLER
# Version 1.0

class User < ActiveRecord::Base
  # Represents the attributes of User model that can be mass-assigned.
  attr_accessible :email, :gb_auth_token, :gb_user_id, :enphase_user_id, :enphase_auth_token
end
