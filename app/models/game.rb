class Game < ActiveRecord::Base
 belongs_to :console
 belongs_to :user
 validates :name, :console uniqueness: { case_sensitive: false }
 extend Slugger::ClassMethods
 include Slugger::InstanceMethods
end
