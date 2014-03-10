class ArticlesController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]

  #articles
  #GET /articles
  def index
    @articles = current_user.articlelist.search(params[:search]).paginate(page: params[:page], :per_page => 10)
  end

  #article
  #GET /articles/:id
  def show
  	@article = Article.find(params[:id])
    @micropost  = current_user.microposts.build
    @feed_items = current_user.articlefeed(params[:id]).paginate(page: params[:page], :per_page => 15)
    @microposts = @article.microposts.paginate(page: params[:page], :per_page => 10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  #new_article
  #GET /articles/new
  def new
  	@article = Article.new
  end

  #edit_article
  #GET /articles/:id/edit
  def edit
    @article = Article.find(params[:id])
  end

  #POST /articles
  def create
  	@article = Article.new(params[:article])
  	@article.user_id = current_user.id
    lista = User.addresslist(@article.addressees, current_user.nic)
    if lista.length > 1
   	  if @article.save
        Articleaddressee.insert_addressees(@article.id, lista, current_user.id)
  	    redirect_to @article
  	  end
    else
      render :new
  	end
  end

  #PUT /articles/:id
  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      redirect_to @article
    else
      render :edit
    end
  end

  #DELETE /articles/:id
  def destroy
    @article = Article.find(params[:id])
    @microposts = Micropost.where(thing_id: @article.id)
    @microposts.each do |micropost|
      micropost.destroy
    end
    Articleaddressee.delete_addressees(@article.id)
    @article.destroy
  	redirect_to root_path
  end

  def listArticleaddressees
    lista = Articleaddressee.list_article_addressees(params[:micid]).to_a
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

end