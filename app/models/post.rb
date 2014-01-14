class Post < ActiveRecord::Base
	default_scope { order(created_at: :desc) }
	scope :published, -> { where(published: true) }
	scope :preview, -> { select("id, left(body, 100)") } # TODO: Doesn't work yet
end
