class Project < ActiveRecord::Base
  validates :subject, :content, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy
end
