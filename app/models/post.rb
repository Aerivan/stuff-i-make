class Post < ActiveRecord::Base
	default_scope { order(created_at: :desc) }
	scope :published, -> { where(published: true) }
	scope :previews, -> { select("id, title, substring(body from '<p>.*?<\/p>') as body, published, created_at, updated_at") }
end
