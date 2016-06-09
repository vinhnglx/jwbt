FactoryGirl.define do
  factory :product do
    name { FFaker::Name.last_name }
    price { rand * 100 }
  end
end
