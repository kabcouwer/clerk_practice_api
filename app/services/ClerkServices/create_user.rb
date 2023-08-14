module ClerkServices
  class CreateUser < ApplicationService
    attr_reader :clerk_id

    def initialize(body)
      @clerk_id = body[:data][:id]
    end

    def call
      create_user
    end

    private

    def create_user
      user = User.new(
        clerk_id: @clerk_id
      )

      if user.save
        # UserMailer.welcome_email(user).deliver_now
        return true
      else
        return false
      end
    end
  end
end
