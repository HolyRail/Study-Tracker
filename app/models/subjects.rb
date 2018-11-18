class Subjects < ActiveRecord::Base
  has_many :schedules
  belongs_to :user

end
