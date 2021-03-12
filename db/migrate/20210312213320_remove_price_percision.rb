class RemovePricePercision < ActiveRecord::Migration[6.1]
  def change
    change_column :instruments, :price, :decimal, precision: 15, scale: 2, default: 0.0
    change_column :bids, :price, :decimal, precision: 15, scale: 2, default: 0.0
  end
end
