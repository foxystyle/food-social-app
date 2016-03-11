class Post < ActiveRecord::Base
  # Relations
  belongs_to :user
  has_many :edits
  has_many :votes

  default_scope -> { order created_at: :desc }
  validates :user_id, presence: true
  validates :content,
    presence: true,
    length: {maximum: 200}

end
