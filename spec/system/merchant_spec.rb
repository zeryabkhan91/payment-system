# frozen_string_literal: true

require 'system_helper'

describe 'Merchant page' do
  let(:admin) { create(:user, :admin) }

  before :example do
    resize_window_desktop
  end

  describe 'logged out user' do
    it 'should not access Merchants page' do
      visit merchants_path
      expect(page).not_to have_content('Merchants List')
    end
  end

  describe 'logged in admin user' do
    let(:merchant) { create(:user) }
    let(:transaction) { create_list(:transaction, 1) }
    let(:merchant_with_transaction) { create(:user, transactions: transaction) }

    before do
      merchant
      merchant_with_transaction
      login_as(admin)
      visit merchants_path
    end

    it 'should have access to Merchants page' do
      expect(page).to have_content('Merchants List')
    end

    it 'should have Table of all Merchants' do
      expect(page).to have_css('table tbody tr', count: User.merchants.count)
    end

    it 'should able to delete a Merchant' do
      find("#delete-#{merchant.id}").click
      expect(page).to have_content('Merchant deleted Successfully')

      expect(page).to_not have_content(merchant.email)
    end

    it 'should not able to delete Merchant with Transactions' do
      find("#delete-#{merchant_with_transaction.id}").click
      expect(page).to have_content('Cannot delete record because dependent transactions exist')

      expect(page).to have_content(merchant_with_transaction.email)
    end
  end
end
