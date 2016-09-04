FactoryGirl.define do
  factory :user do
    first_name 'first name'
    last_name 'last name'
  end

  factory :profile do
    bio 'bio'
    gender 'F'
    user
  end

  factory :ticket do
    price '5'
    user
    seat
  end

  factory :seat do
    seat_no 'seat no'
    room
  end

  factory :room do
    room_no 'room no'
  end
end
