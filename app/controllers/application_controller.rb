class ApplicationController < ActionController::Base
  protect_from_forgery
  # add the session helper to all the controllers
  include SessionsHelper
  
end
