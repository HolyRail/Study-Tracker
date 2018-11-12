class Subjects < ActiveRecord::Base
  has_many :schedules
  belongs_to :users

end
