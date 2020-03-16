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
end
