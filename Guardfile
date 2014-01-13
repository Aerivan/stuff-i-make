# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :bundler do
  watch('Gemfile')
  # Uncomment next line if your Gemfile contains the `gemspec' command.
  # watch(/^.+\.gemspec/)
end

guard :annotate do
  watch( 'db/schema.rb' )

  # Uncomment the following line if you also want to run annotate anytime
  # a model file changes
  #watch( 'app/models/**/*.rb' )

  # Uncomment the following line if you are running routes annotation
  # with the ":routes => true" option
  #watch( 'config/routes.rb' )
end

guard :livereload do
  watch(%r{^app/.+\.(erb|haml|slim|js|css|scss|sass|coffee|eco|png|gif|jpg)})
  watch(%r{^app/helpers/.+\.rb})
  watch(%r{^public/.+\.html})
  watch(%r{^config/locales/.+\.yml})
end
