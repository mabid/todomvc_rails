FactoryGirl.define do
  factory :todo do
    sequence(:text) { |n| "this is some text in todo_#{n}"}
    position 2
    completed false
  end
end
