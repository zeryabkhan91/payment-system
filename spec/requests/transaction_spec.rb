require 'rails_helper'

describe 'Active merchant' do
  let(:user) { create(:user) }
  let(:signin_params) { { user: { email: user.email, password: user.password } } }
  let(:auth_params) { login_user(signin_params) }
  let(:headers) { { Authorization: auth_params['auth_token'] } }

  context 'try to create transaction' do
    it 'should returns HTTP status 200' do
      post "/api/transactions", params: {
        transaction: {
          name: Faker::Name.name,
          customer_email: Faker::Internet.email,
          amount: Faker::Number.between(from: 1, to: 10)
        }
      }, headers: headers

      aggregate_failures do
        expect(response).to have_http_status(200)
      end
    end
  end

  context 'try to approve transaction' do
    let(:transaction) { create(:transaction) }
    it 'should returns HTTP status 200' do
      put "/api/transactions/#{transaction.id}", params: {
        state: 'approve'
      }, headers: headers

      expect(response).to have_http_status(200)
    end
  end

  context 'try to approve charged transaction' do
    let(:transaction) { create(:transaction, status: 'approved') }
    it 'should returns HTTP status 422' do
      put "/api/transactions/#{transaction.id}", params: {
        state: 'approve'
      }, headers: headers

      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      expect(json['error']).to eql("Transaction can't be approved")
    end
  end

  context 'try to reverse charged transaction' do
    let(:transaction) { create(:transaction, status: 'approved') }
    it 'should returns HTTP status 422' do
      put "/api/transactions/#{transaction.id}", params: {
        state: 'reverse'
      }, headers: headers

      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      expect(json['error']).to eql("Transaction can't be reversed")
    end
  end

  context 'try to refund charged transaction' do
    let(:transaction) { create(:transaction, status: 'approved', type: 'ChargeTransaction') }
    it 'should returns HTTP status 200' do
      put "/api/transactions/#{transaction.id}", params: {
        state: 'refund'
      }, headers: headers

      expect(response).to have_http_status(200)
    end
  end
end

describe 'Inactive merchant: POST /api/transaction' do
  let(:user) { create(:user, status: 1) }
  let(:signin_params) { { user: { email: user.email, password: user.password } } }
  let(:auth_params) { login_user(signin_params) }
  let(:headers) { { Authorization: auth_params['auth_token'] } }

  context 'try to create transaction' do
    it 'should returns HTTP status 422' do
      post "/api/transactions", params: {
        transaction: {
          name: Faker::Name.name,
          customer_email: Faker::Internet.email,
          amount: Faker::Number.between(from: 1, to: 10)
        }
      }, headers: headers

      expect(response).to have_http_status(422)
    end
  end
end
