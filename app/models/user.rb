class User < ActiveRecord::Base
  has_many :consoles
  has_many :games, :through => :consoles

  has_secure_password

   def slug
    slug = self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
   end

    def self.find_by_slug(slug)
    @slug = slug
    format_slug_beginning
    results = self.where("username LIKE ?", @short_slug)
    results.detect do |result|
      result.slug === @slug
    end
  end

  def self.format_slug_beginning
    slug_beginning = @slug.split("-")[0]
    slug_beginning.prepend("%")
    slug_beginning << "%"
    @short_slug = slug_beginning
  end



end
