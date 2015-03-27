# Copyright (C) 2015 TopCoder Inc., All Rights Reserved.
# 
# This file represents the EnphaseEnergyLifetimeDailyReading model.
#
# Author TCSASSEMBLER
# Version 1.0

class EnphaseEnergyLifetimeDailyReading < ActiveRecord::Base

  # Represents the attributes of EnphaseEnergyLifetimeDailyReading model that can be mass-assigned.
  attr_accessible :enphase_energy_lifetime_id, :system_id, :production_enwh, :enphase_user_id, :est_date
  
  # Association to EnphaseEnergyLifetime model.
  belongs_to :enphase_energy_lifetime
end
