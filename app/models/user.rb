class User < ActiveRecord::Base
  has_many :consoles
  has_many :games, :through => :consoles

  has_secure_password




end
