class Upload < ActiveRecord::Base
	belongs_to :post
	has_attached_file :file, styles: {
		medium: '300x300>',
		thumb: '100x100>'
	}
	validates_attachment_content_type :file, :content_type => ['image/jpeg', 'image/jpg', 'image/png']
end
