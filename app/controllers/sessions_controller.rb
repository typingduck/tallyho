
class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    session[:user_id] = "#{auth.provider}:#{auth.uid}"
    session[:user_name] = auth.info.nickname || auth.info.name
    session[:image] = auth.info.image
    redirect_to :votes
  end

  def destroy
    session[:user_id] = nil
    session[:user_name] = nil
    session[:image] = nil
    redirect_to root_path
  end

end
