class ProductGenresController < ApplicationController
  # GET /product_genres
  # GET /product_genres.json
  def index
    @product_genres = ProductGenre.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_genres }
    end
  end

  # GET /product_genres/1
  # GET /product_genres/1.json
  def show
    @product_genre = ProductGenre.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product_genre }
    end
  end

  # GET /product_genres/new
  # GET /product_genres/new.json
  def new
    @product_genre = ProductGenre.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product_genre }
    end
  end

  # GET /product_genres/1/edit
  def edit
    @product_genre = ProductGenre.find(params[:id])
  end

  # POST /product_genres
  # POST /product_genres.json
  def create
    @product_genre = ProductGenre.new(params[:product_genre])

    respond_to do |format|
      if @product_genre.save
        format.html { redirect_to @product_genre, notice: 'Product genre was successfully created.' }
        format.json { render json: @product_genre, status: :created, location: @product_genre }
      else
        format.html { render action: "new" }
        format.json { render json: @product_genre.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /product_genres/1
  # PUT /product_genres/1.json
  def update
    @product_genre = ProductGenre.find(params[:id])

    respond_to do |format|
      if @product_genre.update_attributes(params[:product_genre])
        format.html { redirect_to @product_genre, notice: 'Product genre was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product_genre.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_genres/1
  # DELETE /product_genres/1.json
  def destroy
    @product_genre = ProductGenre.find(params[:id])
    @product_genre.destroy

    respond_to do |format|
      format.html { redirect_to product_genres_url }
      format.json { head :no_content }
    end
  end
end
