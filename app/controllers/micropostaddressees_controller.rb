class MicropostaddresseesController < ApplicationController
  # GET /micropostaddressees
  # GET /micropostaddressees.json
  def index
    @micropostaddressees = Micropostaddressee.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @micropostaddressees }
    end
  end

  # GET /micropostaddressees/1
  # GET /micropostaddressees/1.json
  def show
    @micropostaddressee = Micropostaddressee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @micropostaddressee }
    end
  end

  # GET /micropostaddressees/new
  # GET /micropostaddressees/new.json
  def new
    @micropostaddressee = Micropostaddressee.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @micropostaddressee }
    end
  end

  # GET /micropostaddressees/1/edit
  def edit
    @micropostaddressee = Micropostaddressee.find(params[:id])
  end

  # POST /micropostaddressees
  # POST /micropostaddressees.json
  def create
    @micropostaddressee = Micropostaddressee.new(params[:micropostaddressee])

    respond_to do |format|
      if @micropostaddressee.save
        format.html { redirect_to @micropostaddressee, notice: 'Micropostaddressee was successfully created.' }
        format.json { render json: @micropostaddressee, status: :created, location: @micropostaddressee }
      else
        format.html { render action: "new" }
        format.json { render json: @micropostaddressee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /micropostaddressees/1
  # PUT /micropostaddressees/1.json
  def update
    @micropostaddressee = Micropostaddressee.find(params[:id])
    @micropostaddressee.seen = true
    @micropostaddressee.save
    respond_to do |format|
      format.html { redirect_to @micropostaddressee, notice: 'Micropostaddressee was successfully updated.' }
      format.js
    end
  end

  # DELETE /micropostaddressees/1
  # DELETE /micropostaddressees/1.json
  def destroy
    @micropostaddressee = Micropostaddressee.find(params[:id])
    @micropostaddressee.destroy

    respond_to do |format|
      format.html { redirect_to micropostaddressees_url }
      format.json { head :no_content }
    end
  end
end
