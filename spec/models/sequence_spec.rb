# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sequence, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      factory = FactoryBot.create(:sequence)
      expect(Sequence.new).to be_invalid
      expect(factory).to be_valid
    end
  end
end
