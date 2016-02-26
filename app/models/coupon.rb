class Coupon < ActiveRecord::Base
  belongs_to :restaurant


  has_attached_file :picture, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/



end
