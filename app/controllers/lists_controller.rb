class ListsController < ApplicationController
  before_action :set_list, only: %i[show]

  def index
    @page = 'All Categories'
    @lists = List.all
  end

  def show
    @page = @list.name
    @bookmarks = Bookmark.where(list_id: @list.id)
    @bookmark = Bookmark.new
  end

  def new
    @page = 'New Category'
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
