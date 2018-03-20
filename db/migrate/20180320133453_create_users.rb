class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :uid
      t.string :provider
      t.integer :followers
      t.integer :following

      t.timestamps
    end
  end
end
