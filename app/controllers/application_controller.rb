# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by making this null_session for APIs.
  protect_from_forgery with: :null_session

  # Include the helper module
  # include JsonWebToken

  # Authenticate the user before any action is performed
  # before_action :authenticate_request

  # # Make current_user accessible
  # attr_reader :current_user

  # private

  # # Authenticate the request using JWT tokens
  # def authenticate_request
  #   header = request.headers['Authorization']
  #   header = header.split(' ').last if header.present?

  #   # Decode the JWT token and find the current user
  #   if header
  #     decoded = JsonWebToken.decode(header)
  #     @current_user = User.find(decoded[:user_id]) if decoded
  #   end

  #   # If decoding fails or user not found, return an unauthorized response
  #   render json: { errors: 'Unauthorized' }, status: :unauthorized unless @current_user
  # rescue ActiveRecord::RecordNotFound, JWT::DecodeError
  #   render json: { errors: 'Unauthorized' }, status: :unauthorized
  # end
end
