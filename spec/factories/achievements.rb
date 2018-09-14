FactoryBot.define do
  factory :achievement do
    title 'title'
    description 'description'
    privacy :private_access
    featured false
    cover_image 'some_file.png'

    factory :public_achievement do
      privacy :public_access
    end
  end
end
