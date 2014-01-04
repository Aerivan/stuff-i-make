FactoryGirl.define do
	factory :post do
		title { Faker::Lorem.sentence }
		body { "<p>#{Faker::Lorem.paragraphs(rand(5) + 1).join('</p><p>')}</p>" }
		published true
	end
end