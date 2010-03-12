ActiveRecord::Schema.define :version => 0 do
  create_table :stocktwits_users, :force => true do |t|
    t.string :twitter_id
    t.string :login
    
    # OAuth fields
    t.string :access_token
    t.string :access_secret

    # Basic fields
    t.binary :crypted_password
    t.string :salt

    # Remember token fields
    t.string :remember_token
    t.datetime :remember_token_expires_at

    # This information is automatically kept
    # in-sync at each login of the user. You
    # may remove any/all of these columns.

    t.timestamps
  end
end

