class ProjectsController < ApplicationController
  before_action :set_project, only: [:edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def new
    if params[:back]
      @project = Project.new(projects_params)
    else
      @project = Project.new
    end
  end

  def create
    @project = Project.new(projects_params)
    if @project.save
      redirect_to projects_path, notice: "プロジェクトを作成しました！!"
    else
      render 'new'
    end
  end

  def confirm
    @project = Project.new(projects_params)
    render :new if @project.invalid?
  end

  def edit
  end

  def update
    if @project.update(projects_params)
      redirect_to projects_path, notice: "プロジェクトを更新しました！!"
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "プロジェクトを削除しました！!"
  end

  private
    def projects_params
      params.require(:project).permit(:subject, :content)
    end

    def set_project
      @project = Project.find(params[:id])
    end
end
