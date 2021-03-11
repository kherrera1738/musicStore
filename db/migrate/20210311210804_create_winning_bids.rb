class CreateWinningBids < ActiveRecord::Migration[6.1]
  def change
    create_table :winning_bids do |t|
      t.references :instrument, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
