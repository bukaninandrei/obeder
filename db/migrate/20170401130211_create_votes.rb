class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.boolean    :vote_type,     default: false,    null: false
      t.references :voteable, polymorphic: true, null: false
      t.references :voter,    polymorphic: true
      t.timestamps
    end

    add_column :dishes, :likes_count, :integer, default: 0
    add_column :dishes, :dislikes_count, :integer, default: 0
  end
end
