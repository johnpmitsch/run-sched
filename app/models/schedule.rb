class Schedule < ActiveRecord::Base
  belongs_to :user
  has_many :weeks, dependent: :destroy

  attr_accessor :login
  
  def self.full_marathon
    training_weeks = 18
    {
      :short_run => [3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 4, 3, 3],
      :medium_run => [5, 5, 5, 6, 6, 6, 7, 7, 7, 8, 8, 8, 5, 8, 5, 4, 3, 2, 2],
      :long_run => [5, 6, 7, 8, 10, 11, 12, 14, 16, 16, 17, 18, 19, 20, 22, 12, 8, 8],
      :rest => duplicate_string_array('rest', training_weeks + 1),
      :cross_train => duplicate_string_array('cross train', training_weeks + 1),
      :weeks => training_weeks
    }
  end

  def self.half_marathon
    training_weeks = 12
    {
      :short_run => duplicate_string_array('3', training_weeks + 1),
      :medium_run => [3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5, 2, 2],
      :long_run => [4, 5, 6, 7, 8, 3.1, 9, 10, 6.2, 11, 12, 6],
      :rest => duplicate_string_array('rest', training_weeks + 1),
      :cross_train => duplicate_string_array('cross train', training_weeks + 1),
      :weeks => training_weeks
    }
  end

  def self.ten_k
    training_weeks = 8
    {
      :short_run => [2.5, 2.5, 2.5, 3, 3, 3, 3, 3, 3], 
      :medium_run => [3, 3, 3, 4, 4, 4, 4, 4, 3],
      :long_run => [3, 3.5, 4, 4, 4.5, 5, 5.5, 5],
      :rest => duplicate_string_array('rest', training_weeks + 1),
      :cross_train => duplicate_string_array('cross train', training_weeks + 1),
      :weeks => training_weeks
    }
  end

  def self.five_k
    training_weeks = 8
    {
      :short_run => [1.5, 1.5, 1.5, 1.5, 2, 2, 2, 2, 2],
      :medium_run => [1.5, 1.75, 2, 2.25, 2.5, 2.75, 3, 3, 3],
      :long_run => [3, 3.5, 4, 4, 4.5, 5, 5.5, 5],
      :rest => duplicate_string_array('rest', training_weeks + 1),
      :cross_train => duplicate_string_array('cross train', training_weeks + 1),
      :weeks => training_weeks
    }
  end

  def update_weeks
    total_weeks = self.training_info[:weeks] + 1
    (1..total_weeks).each do |week_num|
      week = Week.where({
        :schedule_id => self.id,
        :number => week_num
      }).first_or_initialize
      week.save!
    end
  end

  def update_days
    training_day = self.start_date(self.training_info[:weeks])

    self.weeks.each_with_index do |week, index|
      (1..7).each do |_x|

        if training_day == self.race_day
          activity = "Race Day"
        elsif training_day == self.race_day - 1 || training_day == self.race_day - 2
          activity = "rest"
        else
          activity_type = self.send(training_day.strftime('%A').downcase.to_sym).sub(" ","_").to_sym
          activity = self.training_info[activity_type][index]
        end

        day = Day.where({
          :week_id => week.id,
          :activity => activity,
          :date => training_day,
          :completed => false
        }).first_or_initialize
        day.save!

        return true if training_day == self.race_day
        training_day += 1
      end
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
