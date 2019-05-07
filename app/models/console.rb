class Console < ActiveRecord::Base
 belongs_to :user
 has_many :games
 validates :name, uniqueness: { case_sensitive: false }
 extend Slugger::ClassMethods
 include Slugger::InstanceMethods
end
