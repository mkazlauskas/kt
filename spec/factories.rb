FactoryGirl.define do

  factory :reed_muller do
    r 2
    m 4
    binary_vector
    channel
  end

  factory :binary_vector do
    size 11
    elements '01101001010'
  end

  factory :channel do
    reliability 95
  end
end