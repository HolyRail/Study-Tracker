class Subject < ActiveRecord::Base
  has_many :schedules
  belongs_to :user
  #attr_protected :schedule_id
end
