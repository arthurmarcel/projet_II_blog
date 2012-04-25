require "base64"

class SessionsController < ApplicationController
	
	before_filter :require_not_logged, :only => [:new]

  def require_not_logged
    if session[:current_user]
	    redirect_to posts_path, notice: 'You are already logged !'
    end
  end

	def new
		if params["opt"]
			options = params["opt"]
			key = OpenSSL::PKey::RSA.new File.read 'keys/blog_priv.pem'
			encoded = Base64.urlsafe_decode64(options)
			decoded = key.private_decrypt encoded
			param = []
			param = decoded.split(';')
			login = param[0]
			secret = param[1]
		
			if login && secret && session["#{secret}"] && (Time.now.to_i - session["#{secret}"]) < 15	
				@user = login
				session[:current_user] = @user
				session["#{secret}"] = nil
				redirect_to posts_path
			else
				format.html { redirect_to posts_path, notice: 'Authentication failed !' }
			end
		else
			key = OpenSSL::PKey::RSA.new File.read 'keys/blog_priv.pem'
			var = (0...50).map{ ('a'..'z').to_a[rand(26)] }.join
			crypted = key.private_encrypt "#{var}"
			encoded = Base64.urlsafe_encode64(crypted)
			session["#{var}"] = Time.now.to_i
			redirect_to "http://localhost:4567/sauth/sessions/new?app=blog&origin=sessions&secret=#{encoded}"
		end
	end
end
