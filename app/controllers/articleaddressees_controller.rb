class ArticleaddresseesController < ApplicationController
  # GET /articleaddressees
  # GET /articleaddressees.json
  def index
    @articleaddressees = Articleaddressee.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articleaddressees }
    end
  end

  # GET /articleaddressees/1
  # GET /articleaddressees/1.json
  def show
    @articleaddressee = Articleaddressee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @articleaddressee }
    end
  end

  # GET /articleaddressees/new
  # GET /articleaddressees/new.json
  def new
    @articleaddressee = Articleaddressee.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @articleaddressee }
    end
  end

  # GET /articleaddressees/1/edit
  def edit
    @articleaddressee = Articleaddressee.find(params[:id])
  end

  # POST /articleaddressees
  # POST /articleaddressees.json
  def create
    @articleaddressee = Articleaddressee.new(params[:articleaddressee])

    respond_to do |format|
      if @articleaddressee.save
        format.html { redirect_to @articleaddressee, notice: 'Articleaddressee was successfully created.' }
        format.json { render json: @articleaddressee, status: :created, location: @articleaddressee }
      else
        format.html { render action: "new" }
        format.json { render json: @articleaddressee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articleaddressees/1
  # PUT /articleaddressees/1.json
  def update
    @articleaddressee = Articleaddressee.find(params[:id])
    @articleaddressee.seen = true
    @articleaddressee.save
    respond_to do |format|
      format.html { redirect_to @articleaddressee, notice: 'Articleaddressee was successfully updated.' }
      format.js
    end
  end

  # DELETE /articleaddressees/1
  # DELETE /articleaddressees/1.json
  def destroy
    @articleaddressee = Articleaddressee.find(params[:id])
    @articleaddressee.destroy

    respond_to do |format|
      format.html { redirect_to articleaddressees_url }
      format.json { head :no_content }
    end
  end
end
