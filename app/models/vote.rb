class Vote < ActiveRecord::Base

  # Relations
  belongs_to :user
  belongs_to :post
  
end
