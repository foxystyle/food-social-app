class Post < ActiveRecord::Base
  acts_as_votable
  # Relations
  belongs_to :user
  has_many :edits

  default_scope -> { order created_at: :desc }
  validates :user_id, presence: true
  validates :content,
    presence: true,
    length: {maximum: 200}

end
