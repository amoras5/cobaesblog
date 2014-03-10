class UsersController < ApplicationController
  before_filter :signed_in_user,  only: [:index, :edit, :destroy, :siguiendo_a, :seguido_por]
  before_filter :signed_in_user2, only: [:create, :new]
  before_filter :correct_user,    only: [:edit]
  before_filter :admin_user,      only: :destroy

  #user
  #GET /users/:id
  def show
  	@user = User.find_by_id(params[:id])
    @articles = @user.profilearticlefeed(current_user.id).paginate(page: params[:page], :per_page => 10)
    @feed_items = @user.profilefeed(current_user.id).paginate(page: params[:page], :per_page => 10)
    @microposts = @user.microposts.paginate(page: params[:page], :per_page => 10)
  end

  #new_user
  #GET /users/new
  def new
  	@user = User.new
  end

  #POST /users
  def create
  	@user = User.new(params[:user])
  	if @user.save
      flash[:success] = "Bienvenido a Cb-blog !"
      seguidos = User.addresslist(params[:listaseguido], @user.nic)
      siguiendo =  User.addresslist(params[:listasiguiendo], @user.nic)
      Relationship.create_relationships(seguidos, siguiendo, @user.nic)
      Micropostaddressee.add_microposts_to_new_users(@user.id)
      Articleaddressee.add_articles_to_new_users(@user.id)
      if params[:user][:avatar].present?
        render :crop
      else
        sign_in @user
        redirect_to @user
      end
  	else
  		render :new
  	end
  end

  #DELETE /users/:id
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Usuario Eliminado."
    redirect_to users_url
  end

  #PUT /users/:id
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      if params[:user][:avatar].present?
        render :crop
      else
        flash[:success] = "Perfil Actualizado"
        sign_in @user
        redirect_to @user
      end
    else
      sign_in @user
      render :edit
    end
  end

  #edit_user
  #GET /users/:id/edit
  def edit
  end

  #users
  #GET /users
  def index
    testa = params[:search]
    unless testa == nil
      testa.upcase!
      testa.downcase!
    end
    @users = User.search(testa).paginate(:page => params[:page], :per_page => 10).order('name asc')
  end

  #siguiendo_a_user
  #GET /users/:id/siguiendo_a
  def siguiendo_a
    @title = "Siguiendo a:"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  #seguido_por_user
  #GET /users/:id/seguido_por
  def seguido_por
    @title = "Seguido por:"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

     def signed_in_user
        unless signed_in?
           store_location
           redirect_to signin_path, notice: "Primero tiene que identificarse como usuario."
        end
     end
     def signed_in_user2
        unless !signed_in?
           redirect_to root_url
        end
     end
     def correct_user
        @user = User.find(params[:id])
        redirect_to(root_path) unless current_user?(@user)
     end
     def admin_user
        redirect_to(root_path) unless current_user.admin?
     end

end