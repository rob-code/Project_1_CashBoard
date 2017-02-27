require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require('./models/user.rb')
require('./models/budget.rb')
require('./models/category.rb')
require('./models/target.rb')
require('./models/transaction.rb')

get '/landing' do
  erb(:landing)
end

get '/login' do
  @users = User.all
  erb(:index)
end

get '/login/:id' do
  @user = User.return_by_id(params[:id])
  erb(:dashboard)
end

get '/new_transaction/:id' do
  @user = User.return_by_id(params[:id])
  @categories = Category.all
  erb(:new_transaction)
end

post '/new_transaction/' do
  @transaction = Transaction.new(params)
  @transaction.save()
  @user = User.return_by_id(params[:user_id])
  @category = Category.return_by_id(params[:category_id])
  erb(:transaction_created)
end

get '/all_transactions/:id' do
  @user = User.return_by_id(params[:id])
  @transactions = Transaction.all_for_user(params[:id])
  @categories = Category.all
  erb(:all_transactions)
end

get '/sub_cat/:id/:cat_id' do
  @user = User.return_by_id(params[:id])
  @transactions = Transaction.subcategories(params[:id], params[:cat_id])
  @category = Category.return_by_id(params[:cat_id])
  erb(:category)
end


