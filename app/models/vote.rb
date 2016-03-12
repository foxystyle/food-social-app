class Vote < ActiveRecord::Base
  SCORE_REGEX = /\-1|1/

  # Relations
  belongs_to :user
  belongs_to :post

  validates :score,
    length: {maximum: 1},
    allow_nil: true,
    format: {with: SCORE_REGEX }


end
