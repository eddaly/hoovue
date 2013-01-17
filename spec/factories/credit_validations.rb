# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :credit_validation do
    credit_id "MyString"
    user_id "MyString"
    user_validation false
  end
end
