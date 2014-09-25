class CreateTodos < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :todos, :id => :uuid do |t|
      t.string :title, :null => false
      t.date :due_date, :null => false
      t.text :notes

      t.timestamps
    end
  end
end
