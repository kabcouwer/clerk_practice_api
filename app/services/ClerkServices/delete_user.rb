module ClerkServices
  class DeleteUser
    attr_reader :clerk_id

    def initialize(body)
      @clerk_id = body[:data][:id]
    end

    def call
      delete_user
    end

    private

    def delete_user
      user = User.find_by(clerk_id: @clerk_id)

      if user&.destroy
        return true
      else
        return false
      end
    end
  end
end
