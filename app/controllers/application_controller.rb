class ApplicationController < ActionController::Base

protected

  def authenticate
    redirect_to :login unless user_signed_in?
  end

  def current_user
    @current_user ||= session[:user_id]
  end

  def user_signed_in?
    !!current_user
  end


private

  def get_headers
    request.headers.env.select {
      |k, _| k.in?(ActionDispatch::Http::Headers::CGI_VARIABLES) || k =~ /^HTTP_/
    }
  end
end
