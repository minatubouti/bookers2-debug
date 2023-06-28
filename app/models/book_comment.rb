class BookComment < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
   validates :comment,presence:true
  
  def get_profile_image(width, height)
      unless profile_image.attached?
         file_path = Rails.root.join('app/assets/images/no_image.jpg')
         profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
