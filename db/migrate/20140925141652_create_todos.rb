class CreateTodos < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :todos, :id => :uuid do |t|
      t.string :title, :null => false
      t.date :due_date
      t.text :notes
      t.date :completed_on

      t.timestamps
    end
  end
end
