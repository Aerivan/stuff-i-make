class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def admin?
  	session[:admin?] == :yes
  end

  def authenticate
  	unless admin?
  		options = { alert: "You are not authorized to view that page." }

  		begin
  			redirect_to :back, options
  		rescue ActionController::RedirectBackError => e
  			redirect_to root_url, options
  		end
  	end
  end
end
