class Console < ActiveRecord::Base
 belongs_to :user
 has_many :games
 validates :name, uniqueness: { case_sensitive: false }


 def slug
   name.downcase.split.join("-")
 end

 def self.find_by_slug(slug)
   self.all.detect {|s| s.slug == slug}
 end

 def self.favorite_console
   if Console.all.include?(:id)
     Console.find(Game.group(:console_id).count.sort_by{|k, v| v}.last.first)
   end
 end


end
