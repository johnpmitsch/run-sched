class Week < ActiveRecord::Base
  belongs_to :schedule
  has_many :days
end
