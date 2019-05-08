class Game < ActiveRecord::Base
 belongs_to :console
 belongs_to :user
 validates :console_id, uniqueness: { case_sensitive: false }

 def slug
   name.downcase.split.join("-")
 end

 def self.find_by_slug(slug)
   self.all.detect {|s| s.slug == slug}
 end
 
end
