class RelationshipsController < ApplicationController
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  
  def destroy
     current_user.unfollow(params[:user_id])
    redirect_back(fallback_location: root_path)
  end
  #フォローされている
  def follower
   user = User.find(params[:user_id])
    @users = user.following_users
  end
  #フォローしている
  def followed
    user = User.find(params[:user_id])
    @users = user.follower_users
  end
end
