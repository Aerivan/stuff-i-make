class CreateUpdateTsvPostsTrigger < ActiveRecord::Migration
  def up
		create_trigger(compatibility: 1).name('update_tsv_posts').on(:posts).before(:insert, :update) do
		  "new.tsv :=
     			setweight(to_tsvector('pg_catalog.english', coalesce(new.title,'')), 'A') ||
     			setweight(to_tsvector('pg_catalog.english', coalesce(new.body,'')), 'D');"
		end
  end

  def down
    drop_trigger("update_tsv_posts", "posts")
  end
end
