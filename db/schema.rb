# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140116235026) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.tsvector "tsv"
  end

  add_index "posts", ["tsv"], name: "index_posts_on_tsv", using: :gin

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  # no candidate create_trigger statement could be found, creating an adapter-specific one
  execute(<<-TRIGGERSQL)
CREATE OR REPLACE FUNCTION public.posts_tsv_trigger()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
      begin
        if (tg_op = 'INSERT') then
          perform update_tsv_posts(new.id);
        elsif (tg_op = 'UPDATE') then
          if row(new) is distinct from row(old) then
            perform update_tsv_posts(new.id);
          end if;
        end if;
        return null;
      end;
      $function$
  TRIGGERSQL

  # no candidate create_trigger statement could be found, creating an adapter-specific one
  execute("CREATE TRIGGER update_tsv_posts_tr AFTER INSERT OR UPDATE ON posts FOR EACH ROW EXECUTE PROCEDURE posts_tsv_trigger()")

  # no candidate create_trigger statement could be found, creating an adapter-specific one
  execute(<<-TRIGGERSQL)
CREATE OR REPLACE FUNCTION public.update_tsv_tags()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
      DECLARE
        rec record;
      BEGIN

        if (tg_op = 'DELETE') then
          select *
          into rec
          from posts
          where posts.id = old.taggable_id;
        else
          select *
          into rec
          from posts
          where posts.id = new.taggable_id;
        end if;

        perform update_tsv_posts(rec.id);

        RETURN NULL;
      END;
      $function$
  TRIGGERSQL

  # no candidate create_trigger statement could be found, creating an adapter-specific one
  execute("CREATE TRIGGER update_tsv_tags_tr AFTER INSERT OR DELETE OR UPDATE ON taggings FOR EACH ROW EXECUTE PROCEDURE update_tsv_tags()")

end
