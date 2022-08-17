# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  # Association test
  it { should have_many(:transactions).dependent(:restrict_with_error) }

  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:email) }
end
