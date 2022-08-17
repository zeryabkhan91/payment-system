# frozen_string_literal: true

module UserAuth
  extend ActiveSupport::Concern

  included do
    def inactive_message
      'You are not allowed to log in.'
    end
  end
end
