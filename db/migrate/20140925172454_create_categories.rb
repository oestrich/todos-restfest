class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories, :id => :uuid do |t|
      t.string :name

      t.timestamps
    end

    create_table :categorizations, :id => :uuid do |t|
      t.uuid :category_id
      t.uuid :todo_id
    end
  end
end
