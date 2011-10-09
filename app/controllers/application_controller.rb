class ApplicationController < ActionController::Base
  include Clearance::Authentication
  protect_from_forgery
  respond_to :json
end
