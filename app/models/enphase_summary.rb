# Copyright (C) 2015 TopCoder Inc., All Rights Reserved.
# 
# This file represents the EnphaseSummary model.
#
# Author TCSASSEMBLER
# Version 1.0

class EnphaseSummary < ActiveRecord::Base

  # Represents the attributes of EnphaseSummary model that can be mass-assigned.
  attr_accessible :energy_lifetime, :energy_today, :operational_at, :size_w, :enphase_user_id, 
                  :summary_date
end
