require 'rails_helper'


RSpec.describe Product, type: :model do
  describe 'Validation' do

    context 'saves' do
      it ('should have an id') do

        @category = Category.new
        @category.name = 'Cat1'
        @category.save
        
        @product = Product.new
        @product.name = "ProductName"
        @product.price = Money.new(1000)
        @product.quantity = 50
        @product.category = @category
        @product.save!

        expect(@product.id).to be_present
        expect(@product.name).to eq("ProductName")
        expect(@product.price).to eq(Money.new(1000))
        expect(@product.quantity).to eq(50)
        expect(@product.category).to eq(@category)
      end
    end
    
    context 'validate :name, presence: true' do
      it ('should fail with no name') do

        @category = Category.new
        @category.name = 'Cat2'
        @category.save
        
        @product = Product.new
        @product.price = Money.new(1000)
        @product.quantity = 50
        @product.category = @category
        @product.save

        expect(@product.errors.full_messages.include? "Name can't be blank").to be true
        expect(@product.id).not_to be_present
        
      end
    end
    
    context 'validate :price, presence: true' do
      it ('should fail with no price') do

        @category = Category.new
        @category.name = 'Cat3'
        @category.save
        
        @product = Product.new
        @product.name = "ProductName"
        @product.quantity = 50
        @product.category = @category
        @product.save

        expect(@product.errors.full_messages.include? "Price can't be blank").to be true
        expect(@product.id).not_to be_present
      
      end
    end
    
    context 'validate :quantity, presence: true' do
      it ('should fail with no quanity') do

        @category = Category.new
        @category.name = 'Cat4'
        @category.save
        
        @product = Product.new
        @product.name = "ProductName"
        @product.price = Money.new(1000)
        @product.category = @category
        @product.save

        expect(@product.errors.full_messages.include? "Quantity can't be blank").to be true
        expect(@product.id).not_to be_present
        
      end
    end
    
    context 'validate :category, presence: true' do
      it ('should fail with no category') do

        @category = Category.new
        @category.name = 'Cat5'
        @category.save
        
        @product = Product.new
        @product.name = "ProductName"
        @product.price = Money.new(1000)
        @product.quantity = 50
        @product.save

        expect(@product.errors.full_messages.include? "Category can't be blank").to be true
        expect(@product.id).not_to be_present
        
      end
    end

  end
end
