class Restaurant < ActiveRecord::Base
  has_many :coupons

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  has_attached_file :logo, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/
end
