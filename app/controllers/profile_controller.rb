class ProfileController < ApplicationController
  before_action :require_user!, only: %i[index]

  def index
    @title = "Store - Profile"
    @user = current_user
  end
end
