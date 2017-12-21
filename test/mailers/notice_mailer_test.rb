require 'test_helper'

class NoticeMailerTest < ActionMailer::TestCase
  test "sendmail_project" do
    mail = NoticeMailer.sendmail_project
    assert_equal "Sendmail project", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
