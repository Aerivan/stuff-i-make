# This migration was auto-generated via `rake db:generate_trigger_migration'.
# While you can edit this file, any changes you make to the definitions here
# will be undone by the next auto-generated trigger migration.

class CreateTriggerPostsInsertUpdate < ActiveRecord::Migration
  def up
    drop_trigger("posts_before_insert_update_row_tr", "posts", :generated => true)

    create_trigger("posts_before_insert_update_row_tr", :generated => true, :compatibility => 1).
        on("posts").
        before(:insert, :update) do
      "new.tsv := tsvector_update_trigger(tsv, 'pg_catalog.english', title, body);"
    end
  end

  def down
    drop_trigger("posts_before_insert_update_row_tr", "posts", :generated => true)

    create_trigger("posts_before_insert_update_row_tr", :generated => true, :compatibility => 1).
        on("posts").
        before(:insert, :update) do
      "new.tsv := tsvector_update_trigger(tsv_body, 'pg_catalog.english', body);"
    end
  end
end
