class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_project.subject
  #
  def sendmail_project(project)
    @project = project

    mail to: @project.user.email, subject: '【ToGoal】新しいプロジェクトが作成されました！'
  end
end
