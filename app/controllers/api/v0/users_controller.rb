module Api
  module V0
    class UsersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :user_not_found
    
      def show
        user = User.find(params[:id])
        render json: UserSerializer.new(user)
      end

      private

      def user_not_found
        render json: { error: "Couldn't find User" }, status: :not_found
      end
    end
  end
end
