class Photo < ApplicationRecord
  mount_uploaders :images, PhotoUploader
end
