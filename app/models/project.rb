class Project < ActiveRecord::Base
  validates :subject, :content, presence: true

  belongs_to :user
end
