# frozen_string_literal: true

require 'system_helper'

describe 'Home' do
  let(:admin) { create(:user, :admin) }

  before :example do
    resize_window_desktop
  end

  describe 'logged out user' do
    it 'should not have access to homepage' do
      visit root_path
      expect(page).not_to have_content('Welcome to payment System')
    end
  end

  describe 'logged in admin user' do
    before do
      login_as(admin)
      visit root_path
    end

    it 'should have access to homepage' do
      expect(page).to have_content('Welcome to payment System')
    end

    it 'should have access to Merchant button' do
      expect(page).to have_selector(:link_or_button, 'Merchants')
    end
  end
end
