class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :item
      t.references :item
      
      t.timestamps
    end
  end
end
