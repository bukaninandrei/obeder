class Dish < ApplicationRecord
  extend Enumerize
  include DishRepository
  include Voteable

  has_many :menu_dishes
  has_many :menus, through: :menu_dishes
  has_many :user_menu_dishes
  has_many :user_menus, through: :user_menu_dishes

  enumerize :dish_type, in: [:soup, :main_dish, :side_dish, :salad, :separate_dish]
end
