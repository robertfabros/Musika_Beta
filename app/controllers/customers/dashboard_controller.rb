# app/controllers/customers/dashboards_controller.rb
module Customers
  class DashboardsController < ApplicationController
    before_action :authenticate_user!

    def show
      puts "Dashboard Controller Loaded"
      @cart_items = current_user.cart.cart_items if current_user.cart
    end
  end
end
