class Console < ActiveRecord::Base
 belongs_to :user
 has_many :games, :dependent => :destroy
 validates :name, presence: { case_sensitive: false }


 def slug
   name.downcase.split.join("-")
 end

 def self.find_by_slug(slug)
   self.all.detect {|s| s.slug == slug}
 end



end
