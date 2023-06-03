# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  disabled   :boolean          default(FALSE)
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  validates_presence_of :name
end
