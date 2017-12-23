class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :notifications, dependent: :destroy
end
