class Schedule < ActiveRecord::Base
  belongs_to :user
  has_many :weeks

  attr_accessor :login
  
  def self.full_marathon
    training_weeks = 18
    {
      :short_run => [3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 4, 3, 3],
      :medium_run => [5, 5, 5, 6, 6, 6, 7, 7, 7, 8, 8, 8, 5, 8, 5, 4, 3, 2, 2],
      :long_run => [5, 6, 7, 8, 10, 11, 12, 14, 16, 16, 17, 18, 19, 20, 22, 12, 8, 8],
      :rest => duplicate_string_array('rest', training_weeks),
      :cross_train => duplicate_string_array('cross train', training_weeks),
      :weeks => training_weeks
    }
  end

  def update_weeks
    (1..self.training_info[:weeks]).each do |week_num|
      week = Week.first_or_create({
        :schedule_id => self.id,
        :number => week_num
      })
      week.save!
    end
  end

  def update_days
    training_day = self.start_date

    self.weeks.each_with_index do |week, index|
      if training_day == self.race_date
        activity = "Race Day"
      elsif training_day == self.race_date - 1 || self.race_date - 1
        activity = "rest"
      else
        activity = self.training_info[training_day.weekday.to_sym][index]
      end

      Day.first_or_create({
        :week_id => week.id,
        :activity => activity,
        :date => training_day,
        :completed => false
      })
      training_day += 1
      break if training_day == self.race_date
    end
  end
  
  def training_info
    Schedule.send(self.race_type.sub(" ","_"))
  end

  def start_date(weeks)
    self.race_day - weeks * 7 - self.race_day.wday + 1
  end

  def self.duplicate_string_array(word, number)
    array = [] 
    number.times do |_x|
      array << word
    end
    array
  end
end
