class Game < ActiveRecord::Base
 belongs_to :console
 belongs_to :user
 validates :name, uniqueness: { case_sensitive: false}
 validates :review, numericality: {less_than_or_equal_to: 10}
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
      self.group(:genre).count.sort_by{|k,v| v}.reverse.first.first
   end

   def self.most_common_developer
      self.group(:developer).count.sort_by{|k,v| v}.reverse.first.first
   end

end
