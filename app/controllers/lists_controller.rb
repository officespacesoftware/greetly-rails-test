class ListsController < ApplicationController
  # GET /lists
  def index
    @lists = List.all
    if request_is_json?
      render :json => { status: 200, lists: @lists }
    end
  end

  # GET /lists/1
  def show
    @list = List.find(params[:id])
    if request_is_json?
      render :json => { status: 200, lists: @list }
    end
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
    @list = List.find(params[:id])
  end

  # POST /lists
  def create
    @list = List.new(params[:list])

    if request_is_json?
      if @list.save
        render :json => { status: 201, list: @list }
      else
        render :json => { :errors => @list.errors.full_messages }
      end
    else
      if @list.save
        redirect_to @list, notice: 'List was successfully created.'
      else
        render action: "new"
      end
    end
  end

  # PUT /lists/1
  def update
    @list = List.find(params[:id])

    if request_is_json?
      if @list.update_attributes(params[:list])
        render :json => { status: 200, list: @list }
      else
        render :json => { :errors => @list.errors.full_messages }
      end
    else
      if @list.update_attributes(params[:list])
        redirect_to @list, notice: "List #{@list.title} was successfully updated."
      else
        render action: "edit"
      end
    end
  end

  # DELETE /lists/1
  def destroy
    @list = List.find(params[:id])
    @list.destroy
    if request_is_json?
      if @list.save
        render :json => { status: 200, destroyed: true }
      else
        render :json => { :errors => @list.errors.full_messages }
      end
    else
      redirect_to lists_url, notice: "List #{@list.title} was successfully deleted."
    end
  end

  private
  def request_is_json?
    response.request.env["CONTENT_TYPE"] == "application/json"
  end
end
