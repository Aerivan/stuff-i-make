class CreateTsvUpdateTriggers < ActiveRecord::Migration

def self.up
    execute <<SQL

      CREATE FUNCTION update_tsv_posts(integer) RETURNS void LANGUAGE plpgsql AS $$
      DECLARE
        rec record;
      BEGIN
        update posts
        set tsv = q.weighted_tsv
        from
          (select posts.id,
            setweight(to_tsvector(coalesce(posts.title, '')), 'A')
              || setweight(to_tsvector(coalesce(posts.body, '')), 'D')
              || setweight(to_tsvector(coalesce(string_agg(tags.name, ' '), '')), 'B')
                  as weighted_tsv
          from posts
          left join taggings on (taggings.taggable_type = 'Post' and taggings.taggable_id = posts.id)
          left join tags on taggings.tag_id = tags.id
          group by posts.id, posts.title, posts.body) q
        where q.id = posts.id and posts.id = $1;
      END;
      $$;


      create or replace function posts_tsv_trigger() returns trigger as $$
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
      $$ language plpgsql;


      create trigger update_tsv_posts_tr after insert or update on posts
        for each row execute procedure posts_tsv_trigger();



      CREATE FUNCTION update_tsv_tags() RETURNS trigger LANGUAGE plpgsql AS $$
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
      $$;

      create trigger update_tsv_tags_tr after insert or update or delete on taggings
        for each row execute procedure update_tsv_tags();

SQL
  end
  
end
