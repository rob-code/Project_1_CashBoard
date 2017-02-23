require_relative('../db/sqlrunner.rb')

class Transaction

  attr_accessor :merchant_name, :amount, :category_id,
  attr_reader :id, :user_id

  def initialize (options)
    @id = options['id'].to_i if options['id']
    @merchant_name = options['merchant_name']
    @amount = options['amount'].to_f
    @category_id = options['category_id'].to_i
    @user_id = options['user_id'].to_i
  end






end

