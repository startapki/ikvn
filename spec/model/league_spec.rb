require 'rails_helper'

RSpec.describe League do
  it 'should have valid factory' do
    expect(build(:league)).to be_valid
  end
end
