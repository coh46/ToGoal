class Project < ActiveRecord::Base
  validates :subject, :content, presence: true
end
