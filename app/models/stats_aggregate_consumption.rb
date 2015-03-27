# Copyright (C) 2015 TopCoder Inc., All Rights Reserved.
# 
# This file represents the StatsAggregateConsumption model.(which will be later used in the app).
#
# Author TCSASSEMBLER
# Version 1.0

class StatsAggregateConsumption < ActiveRecord::Base

  # Represents the attributes of StatsAggregateConsumption model that can be mass-assigned.
  attr_accessible :electric_provider_id, :enwh, :month, :user_id, :year, :calculated_cost
end
