module MenuRepository
  extend ActiveSupport::Concern

  included do
    scope :for_date, -> (date) { where(date: date) }
    scope :current_menu, -> (date) { find_or_create_by(date: date) }
    scope :for_date_range, -> (date, offset) { where(date: (date - offset.days)..(date + offset.days)).order(:date) }
    scope :except_date, -> (date) { where.not(date: date) }
    scope :ready, -> { where(ready: true) }
    scope :closest_days_menus, -> (date) do
      includes(menu_dishes: :dish)
      .for_date_range(date, Settings.closest_menus_date_offset)
      .except_date(date)
    end
  end
end
