class SessionController < ApplicationController
	def login
	end

  def create
  	if params[:password] == ENV['admin_password']
  		session[:admin?]  = :yes
  		redirect_to root_path, notice: 'Successfully logged in.'
  	else
  		redirect_to :back, alert: 'Check your caps-lock key and try again.'
  	end
  end

  def destroy
  	session.delete :admin?
  	redirect_to root_path, notice: 'You are now logged out.'
  end
end
