# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product_field do
    name "MyString"
    field_type "MyString"
    required false
    product_genre nil
  end
end
