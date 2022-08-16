# frozen_string_literal: true

module Api
  module Devise
    class SessionsController < ::Devise::SessionsController
      def create
        self.resource = warden.authenticate!(auth_options)
        sign_in(resource_name, resource)

        render json: { user: current_user, status: :ok }
      end

      private

      def respond_to_on_destroy
        head :no_content
      end
    end
  end
end
