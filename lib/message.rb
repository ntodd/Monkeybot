class Message < ActiveRecord::Base
  
  belongs_to :user, :touch => true
  
end