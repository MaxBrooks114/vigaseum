class User < ActiveRecord::Base
  has_many :consoles
  has_many :games, through: :consoles
  validates :username, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: {case_sensitive: false }
  has_secure_password
  extend Slugger::ClassMethods
  include Slugger::InstanceMethods



end
