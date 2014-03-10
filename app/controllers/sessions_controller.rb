class SessionsController < ApplicationController
  before_filter :signed_in_user3, 	only: :new

  #new_session
  #GET /sessions/new
  def new
  end

  #sessions
  #POST /sessions
  def create
	user = User.find_by_email(params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
      if params[:recordarme]
  	    sign_in_temp user
  	  else
        sign_in user
      end
      redirect_to root_path
  	else
  	  flash.now[:error] = 'Combinacion email/password no fue validada'
  	  render 'new'
  	end
  end

  #session
  #DELETE /sessions/:id
  def destroy
  	signed_out
  	redirect_to root_path
  end

  private
    def signed_in_user3
	    unless !signed_in?
	    redirect_to root_url
	  end
  end

end