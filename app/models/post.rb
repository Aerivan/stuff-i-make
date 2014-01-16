class Post < ActiveRecord::Base
	include PgSearch

	default_scope { order(created_at: :desc) }
	scope :published, -> { where(published: true) }
	scope :previews, -> { select("id, title, substring(body from '<p>.*?<\/p>') as body, published, created_at, updated_at") }

	pg_search_scope :search, against: [:title, :body ],
		using: {
			tsearch: {
				dictionary: 'english',
				prefix: true,
				tsvector_column: 'tsv'
			}
		}

	trigger.before(:insert, :update) do
		"new.tsv := tsvector_update_trigger(tsv, 'pg_catalog.english', title, body);"
	end
end
