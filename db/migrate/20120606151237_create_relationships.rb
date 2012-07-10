class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    
    #efficiency
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    
    #composite index, to enforce uniqueness of pairs of follower-followed
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
