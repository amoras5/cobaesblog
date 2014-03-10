class MicropostsController < ApplicationController
  before_filter :signed_in_user,  only: [:create, :destroy]
  before_filter :correct_user,  only: :destroy

  #microposts
  #POST /microposts
  def create
    @micropost = current_user.microposts.build(params[:micropost])
    case @micropost.thing
      when 1
        lista = User.addresslist(@micropost.addressees, current_user.nic)
        if lista.length > 1
          if @micropost.save
            flash[:success] = "Mensaje creado !"
            Micropostaddressee.insert_addressees(@micropost.id, lista, current_user.id)
            redirect_to root_path
          else
            @feed_items = []
            render 'static_pages/inicio'
            render 'static_pages/home'
          end
        else
          redirect_to root_path
        end
      when 3
        if @micropost.save
          redirect_to :controller => 'articles', :action => 'show', :id => @micropost.thing_id
        else
          redirect_to root_path
        end
    end
  end

  #micropost
  #DELETE /microposts/:id
  def destroy
    @micropost.destroy
    Micropostaddressee.delete_addressees(@micropost.id)
    Micropost.delete_replies(@micropost.id)
    redirect_to :back 
  end

  #micropost
  #GET /microposts/countNews
  def countNews
    @mics_count = Micropost.microposts_count(current_user)
    @arts_count = Article.articles_count(current_user)
    @news_count = @mics_count + @arts_count
    if @news_count > 9
      @fileName = '10'
    else
      @fileName = format('%02d', @news_count)
    end
  end

  def listMicropostaddressees
    lista = Micropostaddressee.list_micropost_addressees(params[:micid]).to_a
    header = "<thead><tr><th>Usuario</th><th>Estatus</th></tr></thead><tbody>"
    agrupar = lista.group_by{|t| t[0]}.values
    @tabla = agrupar.map do |porcion|
      "<table class='table table-striped' id='tablaEstatus'>\n" << header << "<tr>" << porcion.map do |columna|
        "<td>" << columna.map do |elemento|
          elemento[1]
        end.join("</td><td>") << "</td>"
      end.join("</tr>\n<tr>") << "</tr>\n</tbody></table>\n"
    end.join("\n")
    respond_to do |format|
      format.html
      format.js
    end
  end
  private

    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      if @micropost.nil?
        if current_user.admin?
          @micropost = Micropost.find_by_id(params[:id])
        else
          redirect_to root_path
        end
      end
    end

end