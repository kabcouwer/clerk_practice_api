require 'svix'

class WebhooksController < ApplicationController
  protect_from_forgery with: :null_session # disables CSRF middleware; required for API endpoints

  def index
    begin
      payload = request.body.read
      headers = request.headers
      wh = Svix::Webhook.new(Rails.application.credentials.svix[:secret])

      json = wh.verify(payload, headers)

      # Do something with the message...

      head :no_content
    rescue
      head :bad_request
    end

end
