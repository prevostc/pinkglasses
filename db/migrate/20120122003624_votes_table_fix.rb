class VotesTableFix < ActiveRecord::Migration
   def self.up
     rename_column :votes, :item_id, :hot
     add_column :votes, :not, :integer
   end

   def self.down
     rename_column :votes, :hot, :item_id
     remove_column :votes, :not
   end
end
