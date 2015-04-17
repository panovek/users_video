FactoryGirl.define do
  factory :video do
    video_uid "MyString"
    title "MyString"

    association :user
  end

end
