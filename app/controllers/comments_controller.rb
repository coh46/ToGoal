class CommentsController < ApplicationController
  # コメントを保存、投稿するためのアクションです。
  def create
    # Blogをパラメータの値から探し出し,Blogに紐づくcommentsとしてbuildします。
    @comment = current_user.comments.build(comment_params)
    @project = @comment.project
    @notification = @comment.notifications.build(user_id: @project.user.id )
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html { redirect_to project_path(@project), notice: 'コメントを投稿しました。' }
        format.js { render :index }
        unless @comment.blog.user_id == current_user.id
          Pusher.trigger("user_#{@comment.project.user_id}_channel", 'comment_created', {
            message: 'あなたのプロジェクトにコメントが付きました！！'
          })
        end
        Pusher.trigger("user_#{@comment.project.user_id}_channel", 'notification_created', {
          unread_counts: Notification.where(user_id: @comment.project.user.id, read: false).count
        })
      else
        format.html { render :new }
      end
    end
  end

  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:project_id, :content)
    end
end
