class Space < ActiveRecord::Base
  has_many :admins
  has_many :administrators, through: :admins

  has_many :reservations
  has_many :renters, through: :reservations

  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  has_many :space_uses
  has_many :uses, through: :space_uses

  has_many :photos

  has_many :availabilities

  def self.search(search)
  	if search
  	  where('title ILIKE ?', "%#{search}%")
  	else
  	  all
  	end
  end
end
