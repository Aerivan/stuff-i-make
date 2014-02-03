class AssociatePostsAndUploads < ActiveRecord::Migration
  def change
  	add_reference :posts, :upload, index: true
  	add_reference :uploads, :post, index: true
  end
end
