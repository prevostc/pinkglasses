class Vote < ActiveRecord::Base
  belongs_to :item
  belongs_to :item

  validates :hot,  :presence => true
  validates :not,  :presence => true
end
