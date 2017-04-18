class UserMenuSerializer < ActiveModel::Serializer
  attributes :id, :date, :user_name, :description, :dishes, :neem, :editable

  def user_name
    object.user.name
  end

  def date
    object.menu.date
  end

  def dishes
    menu_dishes = object.menu.menu_dishes
    user_dish_ids = object.dishes.pluck(:id)

    votes = {}
    Vote.select(:vote_type, :voteable_id)
      .where(voteable_id: menu_dishes.pluck(:dish_id), voteable_type: 'Dish', voter: current_user)
      .map { |vote| votes.store(vote[:voteable_id], vote[:vote_type] ? 1 : -1) }

    menu_dishes.map do |menu_dish|
      dish = menu_dish.dish
      dish_hash = DishSerializer.new(dish).attributes
      dish_hash[:selected] = user_dish_ids.include?(dish.id)
      dish_hash[:default] = menu_dish.default
      dish_hash[:vote_type] = votes[dish.id].nil? ? 0 : votes[dish.id]

      dish_hash
    end
  end
end
