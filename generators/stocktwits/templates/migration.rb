class StocktwitsMigration < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :stocktwits_id
      t.string :login
      # t.string :access_token - uncomment if you change your are planning to use the "oauth" strategy
      # t.string :access_secret - uncomment if you change your are planning to use the "oauth" strategy

      # t.binary :crypted_password - uncomment if you change your are planning to use the "basic" strategy
      # t.string :salt - uncomment if you change your are planning to use the "basic" strategy


      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
