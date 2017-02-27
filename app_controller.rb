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

get '/transactions/:transaction_id/:user_id/edit' do
  @transaction = Transaction.return_by_id(params[:transaction_id])
  @user = User.return_by_id(params[:user_id])
  @categories = Category.all
  erb(:edit_transaction)
end  

post '/transactions/edit' do
  @transaction = Transaction.return_by_id(params[:transaction_id])
  @transaction.merchant_name = params[:merchant_name]
  @transaction.amount = params[:amount]
  @transaction.category_id = params[:category_id]
  @transaction.update()
  @user = User.return_by_id(params[:user_id])
  erb(:dashboard)
end

post '/transactions/:transaction_id/:user_id/:cat_id/delete' do
  Transaction.delete_by_id(params[:transaction_id])
  @transactions = Transaction.subcategories(params[:user_id], params[:cat_id])
  @user = User.return_by_id(params[:user_id])
  @category = Category.return_by_id(params[:cat_id])
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


