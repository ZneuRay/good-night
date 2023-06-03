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

  it 'is  not valid without a name' do
    subject.name = nil
    expect(subject).to be_invalid
  end
end
