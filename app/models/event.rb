class Event < ApplicationRecord
    
    def start_time
        self.my_related_model.start ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
    end

end
