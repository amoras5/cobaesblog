class StaticPagesController < ApplicationController
  
  #root
  #/
  def inicio
  	if signed_in?
  		@micropost  = current_user.microposts.build
  		@feed_items = current_user.feed.paginate(page: params[:page], :per_page => 10)
  	end
  end

  #ayuda
  #/ayuda
  def ayuda
  end

  #nosotros
  #/nosotros
  def nosotros
  end

  #contacto
  #/contacto
  def contacto
  end
end