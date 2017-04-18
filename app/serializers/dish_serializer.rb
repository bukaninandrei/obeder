class DishSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :dish_type, :rating
end
