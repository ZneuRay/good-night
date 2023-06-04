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
require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to be_invalid
  end

  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  it 'is valid for user1 follow user2' do
    user1.follow(user2)
    expect(user1.following_users).to include(user2)
    expect(user2.followers).to include(user1)
  end

  it 'is not valid to follow a user twice' do
    user1.follow(user2)
    expect(user1.follow(user2)).to be(false)
  end

  it 'is not valid to follow self' do
    expect(user1.follow(user1)).to be(false)
  end
end
