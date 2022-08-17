# frozen_string_literal: true

require 'system_helper'

describe 'Session' do
  let(:admin) { create(:user, :admin) }
  let(:merchant) { create(:user) }

  before :example do
    resize_window_desktop
  end

  describe 'admin user' do
    it 'can log in' do
      visit new_user_session_path

      within('#new_user') do
        find('#user_email').fill_in with: admin.email
        find('#user_password').fill_in with: admin.password
      end

      find('input[name="commit"]').click

      expect(page).to have_content('Welcome to payment System')
    end
  end

  describe 'merchant user' do
    it "can't log in" do
      visit new_user_session_path

      within('#new_user') do
        find('#user_email').fill_in with: merchant.email
        find('#user_password').fill_in with: merchant.password
      end

      find('input[name="commit"]').click

      expect(page).to have_content('You are not allowed to log in.')
    end
  end
end
