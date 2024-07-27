class AddOnSaleToMusics < ActiveRecord::Migration[7.0]
  def change
    add_column :musics, :on_sale, :boolean, default: false
  end
end
