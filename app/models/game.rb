class Game < ActiveRecord::Base
 belongs_to :console
 belongs_to :user
 validates :name, uniqueness: { case_sensitive: false, message: 'That game already exists' }
 validates :review, numericality: {less_than_or_equal_to: 10, message: 'please choose a number between 1 and 10'}
 validates :name, :console_id, presence: true
   def slug
     name.downcase.split.join("-")
   end

   def self.find_by_slug(slug)
     self.all.detect {|s| s.slug == slug}
   end

   def self.best
     self.order(:review).last
   end

   def self.most_common_genre
     self.maximum(:genre)
   end

   def self.most_common_developer
     self.maximum(:developer)
   end

end
