class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all.order(updated_at: :desc)
  end

  def show
    @comment = @project.comments.build
    @comments = @project.comments
    Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]
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
    @project.user_id = current_user.id
    if @project.save
      redirect_to projects_path, notice: "プロジェクトを作成しました！!"
      NoticeMailer.sendmail_project(@project).deliver
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
