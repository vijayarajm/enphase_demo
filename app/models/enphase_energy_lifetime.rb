# Copyright (C) 2015 TopCoder Inc., All Rights Reserved.
# 
# This file represents the EnphaseEnergyLifetime model.
#
# Author TCSASSEMBLER
# Version 1.0

class EnphaseEnergyLifetime < ActiveRecord::Base
  self.table_name = "enphase_energy_lifetime"
  
  # Represents the attributes of EnphaseEnergyLifetime model that can be mass-assigned.
  attr_accessible :start_date, :system_id, :enphase_user_id
  
  # Association to EnphaseEnergyLifetimeDailyReading model.
  has_many :enphase_energy_lifetime_daily_readings
end
