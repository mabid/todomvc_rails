class TodosController < ApplicationController
  
  def index
    @todos = Todo.all
  end

  def show
    @todo = Todo.find(params[:id])
  end

  def create
    @todo = Todo.new(params[:todo])
    @todo.save
    render action: :show
  end

  def update
    @todo = Todo.find(params[:id])
    @todo.update_attributes(params[:todo])
    render action: :show
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    render nothing: true
  end

  def save_order
    ids = params[:todo]
    ids.each_with_index do |id, index|
      todo = Todo.find(id)
      todo.update_attribute(:position, index) if todo
    end
    render nothing: true
  end

end
