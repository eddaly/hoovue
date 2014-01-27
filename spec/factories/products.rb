# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    title "MyString"
    genre "MyString"
    user_id 1
    image "MyString"
    description "MyText"
  end
end
