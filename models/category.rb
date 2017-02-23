require_relative('../db/sql_runner.rb')

class Category

  attr_accessor :category_name
  attr_reader :id

  def initialize (options)
    @id = options['id'].to_i if options['id']
    @category_name = options['category_name']
  end








end