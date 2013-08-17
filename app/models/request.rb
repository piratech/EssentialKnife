class Request < ActiveRecord::Base
  has_many :scan
  
  def read_data data
    self.has_data = true
  end
  
end
