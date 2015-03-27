# Copyright (C) 2015 TopCoder Inc., All Rights Reserved.
# 
# This file represents the DataHarvest model.
#
# Author TCSASSEMBLER
# Version 1.0

class DataHarvest < ActiveRecord::Base

  # Represents the attributes of DataHarvest model that can be mass-assigned.
  attr_accessible :url, :raw_data, :harvest_start_time, :harvest_end_time, :job_id

end
