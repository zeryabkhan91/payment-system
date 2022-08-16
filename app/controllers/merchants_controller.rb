# frozen_string_literal: true

class MerchantsController < ApplicationController
  before_action :set_merchant, except: [:index]

  def index
    @merchants = User.merchants
  end

  def edit; end

  def update
    if @merchant.update(merchant_params)
      flash[:notice] = 'Merchant updated Successfully'
    else
      flash[:alert] = @merchant.errors.full_messages.join
      redirect_to merchants_path
    end
  end

  def destroy
    if @merchant.destroy
      flash[:notice] = 'Merchant deleted Successfully'
    else
      flash[:alert] = @merchant.errors.full_messages.join
    end
    redirect_to merchants_path
  end

  private

  def set_merchant
    @merchant = User.merchants.find_by(id: params[:id])
    return if @merchant.present?

    flash[:alert] = "No Merchant found with id #{params[:id]}"
    redirect_to merchants_path, status: 404
  end
end
