class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :image_path
      t.integer :score
      
      t.timestamps
    end
  end
end
