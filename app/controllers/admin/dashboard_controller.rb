class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["USERNAME"], password: ENV["PASSWORD"]

  def show
    @ProductCount = Product.count()
    @CategoryCount = Category.count()
  end
end
