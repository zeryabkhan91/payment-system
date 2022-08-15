# frozen_string_literal: true

class MerchantsController < ApplicationController
  def index
    @merchants = User.merchants
  end
end
