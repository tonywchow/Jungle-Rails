require 'rails_helper'
require 'pp'


RSpec.describe Product, type: :model do
  describe 'Validations' do
    #validates tests/examples here
    before do
      @category = Category.new(name: 'Category')
      @product = @category.products.new(
        name: "Maple Tree",
        price: 1200.00,
        quantity: 1
      )
    end

    it 'should save successfully when all fields are set' do
      expect(@product.save).to be true
    end

    it 'should have an error message if name is not present' do
      @product.name = nil
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should have an error message if price is not present' do
      @product.price_cents = nil
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should have an error message if quantity is not present' do
      @product.quantity = nil
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should have an error message if Category is not present' do
      @product.category = nil
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
    
  end
end
