# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  password_digest :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  #Direct Associations
  has_many :sent_follow_requests, :class_name => "FollowRequest", :foreign_key => "sender_id", :dependent => :destroy
  has_many :received_follow_requests, :class_name => "FollowRequest", :foreign_key => "recipient_id", :dependent => :destroy
  has_many :okays, :foreign_key => "owner_id", :dependent => :destroy

  #Indirect Associations
  has_many :following, :through => :sent_follow_requests, :source => :recipient
  has_many :followers, :through => :received_follow_requests, :source => :sender
  has_many :okays_of_followed, :through => :following, :source => :okays


  def own_okays
    return Okay.where({ :owner_id => self.id })
  end

  def sent_follow_requests
    return FollowRequest.where({ :sender_id => self.id })
  end





end
