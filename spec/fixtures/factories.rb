require 'factory_girl'

Factory.define(:stocktwits_oauth_user, :class => User) do |u|
  u.stocktwits_id { User.count + 1 }
  u.login 'stocktwitsman'
  u.access_token 'fakeaccesstoken'
  u.access_secret 'fakeaccesstokensecret'
  
  u.name 'Stocktwits Man'
  u.description 'Saving the world for all Stocktwits kind.'
end

Factory.define(:stocktwits_basic_user, :class => User) do |u|
  u.stocktwits_id { User.count + 1 }
  u.login 'stocktwitsman'
  u.password 'test'

  u.name 'Stocktwits Man'
  u.description 'Saving the world for all Stocktwits kind.'
end

Factory.define(:stocktwits_plain_user, :class => User) do |u|
  u.stocktwits_id { User.count + 1 }
  u.login 'stocktwitsman'

  u.name 'Stocktwits Man'
  u.description 'Saving the world for all Stocktwits kind.'
end
