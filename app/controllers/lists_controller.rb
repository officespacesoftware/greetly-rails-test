class ListsController < ApplicationController
  # GET /lists
  def index
    @lists = List.all
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @lists, status: 201 }
    end
  end

  # GET /lists/1
  def show
    @list = List.find(params[:id])
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @list, status: 201 }
    end
  end

  # GET /lists/new
  def new
    @list = List.new
    respond_to do |format|
      format.html { render :new }
      format.json { render json: @list, status: 201 }
    end
  end

  # GET /lists/1/edit
  def edit
    @list = List.find(params[:id])
    respond_to do |format|
      format.html { render :edit }
      format.json { render json: @list, status: 201 }
    end
  end

  # POST /lists
  def create
    @list = List.new(params[:list])

    if @list.save
      respond_to do |format|
        format.html { redirect_to @list, notice: 'List was successfully created.' }
        format.json { render json: @list, status: 201 }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @list, status: 201 }
      end
    end
  end

  # PUT /lists/1
  def update
    @list = List.find(params[:id])

    if @list.update_attributes(params[:list])
      respond_to do |format|
        format.html { redirect_to @list, notice: 'List was successfully updated.' }
        format.json { render json: @list, status: 201 }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @list, status: 201 }
      end
    end
  end

  # DELETE /lists/1
  def destroy
    @list = List.find(params[:id])
    @list.destroy

    respond_to do |format|
      format.html { redirect_to lists_url, notice: 'List was successfully destroyed.' }
      format.json { render json: @list, status: 201 }
    end
  end
end
