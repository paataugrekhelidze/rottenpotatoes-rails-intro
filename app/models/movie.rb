class Movie < ActiveRecord::Base
  def self.with_ratings(ratings)
    if ratings.length > 0
      where(rating: ratings)
    else
      self.all
    end
  end
  
  def self.all_ratings
    self.uniq.pluck(:rating)
  end
  def self.orderby(clicked)
    if (clicked == "title_header")
      order('title')
    else
      order('release_date')
    end
  end
end
