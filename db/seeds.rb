require_relative( '../models/user.rb' )
require_relative( '../models/budget.rb' )
require_relative( '../models/category.rb' )
require_relative( '../models/transaction.rb' )
require_relative( '../models/target.rb' )

require('pry-byebug')

User.delete_all
Category.delete_all
Transaction.delete_all

user1 = User.new({
'first_name' => "Rich",
'second_name' => "Person"
})

user2 = User.new({
'first_name' => "Poor",
'second_name' => "Person"
})

user1.save
user2.save

budget1 = Budget.new({
'total_budget' => 3000,
'user_id' => user1.id
})

budget2 = Budget.new({
'total_budget' => 800,
'user_id' => user2.id
})

budget1.save
budget2.save




category1 = Category.new({
'name' => "Food"
})
category2 = Category.new({
'name' => "Electricity Bill"
})
category3 = Category.new({
'name' => "Gas Bill"
})
category4 = Category.new({
'name' => "Mobile Phone Bill"
})
category5 = Category.new({
'name' => "Eating Out"
})
category6 = Category.new({
'name' => "Clothes"
})
category7 = Category.new({
'name' => "Cinema"
})

category1.save
category2.save
category3.save
category4.save
category5.save
category6.save
category7.save


target1 = Target.new({
'amount' => 30,
'category_id' => category1.id,
'user_id' => user1.id
})
target2 = Target.new({
'amount' => 200,
'category_id' => category6.id,
'user_id' => user1.id
})
target3 = Target.new({
'amount' => 25,
'category_id' => category7.id,
'user_id' => user2.id
})

target4 = Target.new({
'amount' => 150,
'category_id' => category1.id,
'user_id' => user2.id
})

target1.save
target2.save
target3.save
target4.save







transaction1 = Transaction.new({
'merchant_name' => "Waitrose",
'amount' => 37,
'category_id' => category1.id,
'user_id' => user1.id
})
transaction2 = Transaction.new({
'merchant_name' => "Marks and Spencer",
'amount' => 120,
'category_id' => category6.id,
'user_id' => user1.id
})
transaction3 = Transaction.new({
'merchant_name' => "Lidl",
'amount' => 27,
'category_id' => category1.id,
'user_id' => user2.id
})
transaction4 = Transaction.new({
'merchant_name' => "PriMark",
'amount' => 18,
'category_id' => category6.id,
'user_id' => user2.id
})
transaction5 = Transaction.new({
'merchant_name' => "Tesco",
'amount' => 18,
'category_id' => category1.id,
'user_id' => user1.id
})

transaction1.save
transaction2.save
transaction3.save
transaction4.save
transaction5.save

binding.pry
nil
