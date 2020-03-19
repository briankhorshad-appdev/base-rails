# == Schema Information
#
# Table name: follow_requests
#
#  id           :integer          not null, primary key
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :integer
#  sender_id    :integer
#

class FollowRequest < ApplicationRecord

  #direct associations
  belongs_to :sender, :class_name => "User"
  belongs_to :recipient, :class_name => "User"

  #validations
  validates :sender_id, :presence => true
  validates :recipient_id, :presence => true
  validates :recipient_id, :uniqueness => { :scope => [:sender_id], :message => "already requested" }

  def sender
    return User.where({ :id => self.sender_id }).at(0).username
  end

  def recipient
    return User.where({ :id => self.recipient_id }).at(0).username
  end


end
