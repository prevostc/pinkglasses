Factory.define :item do |i|
  #i.sequence(:email) { |n| "foo#{n}@example.com" }
  i.score 0
  i.sequence(:image_path) { |n| "#{n}.jpg" }
end