class AddClosedToInstruments < ActiveRecord::Migration[6.1]
  def change
    add_column :instruments, :closed, :boolean, default: false
  end
end
