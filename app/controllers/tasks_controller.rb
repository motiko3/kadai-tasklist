class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  def index
    if logged_in?
      @task = current_user.tasks.build
      @tasks = current_user.tasks.order(id: :desc)
    end 
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = "タスクを保存しました"
      redirect_to  root_url
    else
      flash.now[:danger] = "タスクの保存に失敗しました"
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = "タスクを更新しました"
      redirect_to @task
    else
      flash.now[:danger] = "タスクの更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = "タスクは削除されました"
    redirect_to tasks_url
  end



 private
 def set_task
   @task = Task.find(params[:id])
 end 
 def task_params
   params.require(:task).permit(:content, :status)
 end
end