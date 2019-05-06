class User < ActiveRecord::based
  has_many :consoles
  has_many :games through :consoles



end
