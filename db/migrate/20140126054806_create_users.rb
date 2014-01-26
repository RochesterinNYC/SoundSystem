class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :soundcloud_id
      t.string :access_token
      t.string :username
      t.string :permalink
      t.string :avatar
      t.string :full_name
      t.string :city
      t.text :description
      t.string :website
      t.integer :track_count
      t.integer :playlist_count
      t.integer :favorites_count
      t.integer :followers_count
      t.integer :followings_count

      t.timestamps
    end
  end
end
