class Content < ActiveRecord::Base
    
    mount_uploader :img, ImageUploader
end
