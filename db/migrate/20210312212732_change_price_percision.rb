class ChangePricePercision < ActiveRecord::Migration[6.1]
  def change
    change_column :instruments, :price, :decimal, scale: 2
    change_column :bids, :price, :decimal, scale: 2
  end
end
