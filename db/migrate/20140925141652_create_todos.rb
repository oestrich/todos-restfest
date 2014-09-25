class CreateTodos < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :todos, :id => :uuid do |t|
      t.string :title
      t.date :due_date
      t.text :notes

      t.timestamps
    end
  end
end
