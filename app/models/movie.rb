class Movie < ActiveRecord::Base
  def self.with_ratings(ratings)
    if ratings.length > 0
      where(rating: ratings)
    else
      self.all
    end
  end
  
  def self.all_ratings
    self.pluck(:rating)
  end
end
