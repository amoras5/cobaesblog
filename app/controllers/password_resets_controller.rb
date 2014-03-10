class PasswordResetsController < ApplicationController
  
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
    if user
  	  user.send_password_reset
      redirect_to root_path, :notice => "Email enviado con instrucciones."
    else
      redirect_to new_password_reset_path, :notice => "No existe ningun usuario con ese email registrado en este blog."
    end
  end

  def edit
  	@user = User.find_by_password_reset_token!(params[:id])
  end

  def update
  	@user = User.find_by_password_reset_token!(params[:id])
  	if @user.password_reset_sent_at < 24.hours.ago
  	  redirect_to new_password_reset_path, :alert => "El tiempo para editar tu contrasena ha explirado."
  	elsif @user.update_attributes(params[:user])
  	  redirect_to root_path, :notice => "La Contrasena ha sido cambiada!"
  	else
  	  render :edit
  	end
  end

end
