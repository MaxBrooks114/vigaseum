class User < ActiveRecord::Base
  has_many :consoles
  has_many :games, through: :consoles
  validates :username, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: {case_sensitive: false }
  has_secure_password

  def slug
    username.downcase.split.join("-")
  end

  def self.find_by_slug(slug)
    self.all.detect {|s| s.slug == slug}
  end



end
