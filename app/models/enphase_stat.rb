# Copyright (C) 2015 TopCoder Inc., All Rights Reserved.
# 
# This file represents the EnphaseStat model.
#
# Author TCSASSEMBLER
# Version 1.0

class EnphaseStat < ActiveRecord::Base
  # will reprsesent a five minute time slice
  attr_accessible :system_id, :enwh, :end_at, :valid_data_on_creation, :enphase_user_id, :end_at_datetime

  # sets valid_data_on_creation before data creation.
  before_create do
    check_enwh
  end

  # returns valid_data_on_creation boolean value.
  def valid_data_on_creation?
    valid_data_on_creation
  end

  def check_enwh
    valid_data_on_creation=false if enwh > 3000
  end
end
