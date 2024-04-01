class Admin::BaseController < ApplicationController
  before_action :authenticate_user_from_token

  layout "admin"
end
