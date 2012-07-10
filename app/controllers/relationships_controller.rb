class RelationshipsController < ApplicationController
  before_filter :signed_in_user

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    # Ajax
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
    # Ajax replace this: redirect_to @user
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    # Ajax
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
    # Ajax replace this: redirect_to @user
  end

end