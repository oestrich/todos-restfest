require 'rails_helper'

describe Todo do
  specify "completing a todo" do
    todo = Todo.create(:title => "homework")
    todo.complete!
    expect(todo).to be_completed
  end

  specify "incompleting a todo" do
    todo = Todo.create(:title => "homework")
    todo.incomplete!
    expect(todo).to_not be_completed
  end
end
