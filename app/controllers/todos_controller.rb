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

end
