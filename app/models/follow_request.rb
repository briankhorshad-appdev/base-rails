# == Schema Information
#
# Table name: follow_requests
#
#  id           :integer          not null, primary key
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


end
