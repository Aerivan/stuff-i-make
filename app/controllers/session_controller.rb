class SessionController < ApplicationController
  def create
  	session[:admin?]  = :yes
  	redirect_to '/', notice: 'Successfully logged in.'
  end

  def destroy
  	session[:admin?]  = :no
  	redirect_to '/', notice: 'You are now logged out.'
  end
end
