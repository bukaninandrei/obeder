class Menu < ApplicationRecord
  include MenuRepository

  has_many :menu_dishes
  has_many :dishes, through: :menu_dishes
  has_many :user_menus
  has_many :users, through: :user_menus

  accepts_nested_attributes_for :menu_dishes, reject_if: :all_blank, allow_destroy: true
end
