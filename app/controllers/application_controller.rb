class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :authenticate_user!

  private

  def authenticate_user!
    redirect_to login_path if current_user.nil?
  end
end
