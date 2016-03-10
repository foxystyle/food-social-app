class Post < ActiveRecord::Base
  belongs_to :user
  has_many :edits
  default_scope -> { order created_at: :desc }
  validates :user_id, presence: true
  validates :content,
    presence: true,
    length: {maximum: 200}

end
