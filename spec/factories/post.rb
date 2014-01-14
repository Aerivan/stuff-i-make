def rand_in_range(from, to)
  rand * (to - from) + from
end

FactoryGirl.define do
	factory :post do
		title { Faker::Company.catch_phrase }
		body { ((4..rand(4..8)).collect { Faker::HTMLIpsum.p(rand(5..25)) }).join }
		published { (rand <= 0.8) ? true : false }
		created_at { Time.at(rand_in_range(2.years.ago.to_f, Time.now.to_f)) }
	end
end