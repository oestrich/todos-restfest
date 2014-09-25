Todo.create({
  :title => "homework",
  :due_date => 3.days.from_now,
  :notes => "calculus, english",
})

Todo.create({
  :title => "research blog post",
  :due_date => 3.days.from_now,
}).complete!

Category.create({
  :name => "Work"
})

Category.create({
  :name => "School"
})
