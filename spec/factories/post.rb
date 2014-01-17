# Utility functions
def rand_in_range(from, to)
  rand * (to - from) + from
end

# Post factory
FactoryGirl.define do
	factory :post do

		# Fixture options
		ignore do
			no_tags false
			random_tags { rand(4..12) }
		end

		# Properties
		title { Faker::Company.catch_phrase }
		body { ((4..rand(4..8)).collect { Faker::HTMLIpsum.p(rand(5..25)) }).join }
		published { (rand <= 0.8) ? true : false }
		created_at { Time.at(rand_in_range(2.years.ago.to_f, Time.now.to_f)) }

		# Hooks
		after(:create) do |post, evaluator|
			unless evaluator.no_tags
				tags = ''

				evaluator.random_tags.times do
					tags << Faker::Lorem.word + ', '
				end

				post.tag_list.add(tags, parse: true)
				post.save!
			end
	  end
	end
end