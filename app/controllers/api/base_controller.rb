# frozen_string_literal: true

module Api
  class BaseController < ApplicationController
    before_action :set_request_format
    before_action :authenticate_user!

    private

    def set_request_format
      request.format = :json
    end
  end
end
