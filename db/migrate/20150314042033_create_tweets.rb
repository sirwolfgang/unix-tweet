class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.belongs_to :user, index: true
      t.string :url
      t.integer :twitter_id
      t.timestamp :scheduled_at

      t.timestamps null: false
    end
    add_foreign_key :tweets, :users
  end
end
