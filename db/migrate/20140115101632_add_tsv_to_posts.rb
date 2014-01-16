class AddTsvToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :tsv, :tsvector
  	add_index(:posts, :tsv, using: 'gin')
  end
end
