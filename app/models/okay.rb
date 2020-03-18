# == Schema Information
#
# Table name: okays
#
#  id          :integer          not null, primary key
#  okay_or_not :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_id    :integer
#

class Okay < ApplicationRecord

  #validations
  validates :owner_id, :presence => true

  #direct associations
  belongs_to :owner, :class_name => "User"

  #indirect associations
  has_many :followers, :through => :owner, :source => :following

  def poster
    return User.where({ :id => self.owner_id }).at(0).username
  end

  def fans
    array_of_user_ids = self.likes.pluck(:fan_id)

    return User.where({ :id => array_of_user_ids })
  end

  def fan_list
    return self.fans.pluck(:username).to_sentence
  end


  def age
    years = Date.today.year - self.created_at.year

    #return time_ago_in_words(self.created_at.now)

    return "over " + years.to_s + " year(s) ago"

  end

  def parse_okay
    if self.okay_or_not == true
      return "okay"
    else
      return "not okay"
    end
  end 


end
