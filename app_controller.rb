require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require('./models/user.rb')
require('./models/budget.rb')
require('./models/category.rb')
require('./models/target.rb')
require('./models/transaction.rb')

get '/login' do
@users = User.all
erb(:index)
end

get '/login/:id' do
@user = User.return_by_id(params[:id])
erb(:dashboard)
end

get '/sub_cat/:id/:cat_id' do

erb(:category)
end


