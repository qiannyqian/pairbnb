class Listing < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  mount_uploaders :photos, PhotoUploader

  accepts_nested_attributes_for :photos, allow_destroy: true
end
