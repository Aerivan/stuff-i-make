class Post < ActiveRecord::Base
	include PgSearch

	acts_as_taggable

	has_many :uploads, dependent: :destroy
	accepts_nested_attributes_for :uploads, reject_if: :no_file? , allow_destroy: true

	default_scope { order(created_at: :desc) }
	scope :published, -> { where(published: true) }
	scope :previews, -> { select("id, title, substring(body from '<p>.*?<\/p>') as body, published, created_at, updated_at") }

	pg_search_scope :search, against: {title: 'A', body: 'D' },
		using: {
			tsearch: {
				dictionary: 'english',
				prefix: true,
				tsvector_column: 'tsv'
			}
		}

	def no_file?(attr)
		attr[:file].nil?
	end
end
