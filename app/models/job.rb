# Copyright (C) 2015 TopCoder Inc., All Rights Reserved.
# 
# This file represents the Job model.
#
# Author TCSASSEMBLER
# Version 1.0

class Job < ActiveRecord::Base

  # Represents the attributes of Job model that can be mass-assigned.
  attr_accessible :end_time, :start_time, :running_time, :name

  def calculated_running_time
    end_time - start_time
  end
end
