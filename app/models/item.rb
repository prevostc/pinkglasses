class Item < ActiveRecord::Base
  has_many :votes
  
  validates :score,  :presence => true
  validates :image_path,  :presence => true

  def self.random
    if (c = count) != 0
      find(:first, :offset => rand(c))
    end
  end
  
  def rank
    Item.count(:all, :conditions => ['score > ?', self.score])
  end
end
