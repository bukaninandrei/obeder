FactoryGirl.define do
  sequence :string, aliases: [:name, :description] do |n|
    "string-#{n}"
  end

  sequence :email do |n|
    "example-#{n}@restream.rt.ru"
  end

  sequence :integer do |n|
    n
  end

  sequence :float do |n|
    n.to_f + 0.5
  end

  sequence :date do |n|
    Date.current + n.days
  end
end
