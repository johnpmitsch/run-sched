class Schedule < ActiveRecord::Base
  belongs_to :user

  attr_accessor :login
end
