class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection
  ActionDispatch::Response::default_charset = nil
end
