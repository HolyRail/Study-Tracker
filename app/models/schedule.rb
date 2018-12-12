class Schedule < ActiveRecord::Base
  belongs_to :subject
  #attr_protected :subject_id
  
  def name
    return self.subject.name
  end
  
end
