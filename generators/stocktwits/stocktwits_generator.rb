class StocktwitsGenerator < Rails::Generator::Base
  default_options :oauth => false, :basic => false, :plain => true

  def manifest
    record do |m|
      m.class_collisions 'User'

      m.migration_template 'migration.rb', 'db/migrate', :migration_file_name => 'stocktwits_migration'
      m.template 'user.rb', File.join('app','models','user.rb')
      m.template 'stocktwits.yml', File.join('config','stocktwits.yml')
    end
  end

  protected

  def banner
    "Usage: #{$0} stocktwits"
  end

  def add_options!(opt)
    opt.separator ''
    opt.separator 'Options:'
    
    opt.on('-O', '--oauth', 'Use the OAuth authentication strategy to connect to Stocktwits. (default)') { |v| 
      options[:oauth] = v
      options[:basic] = !v
      options[:plain] = !v
    }

    opt.on('-B', '--basic', 'Use the HTTP Basic authentication strategy to connect to Stocktwits.') { |v| 
      options[:basic] = v
      options[:oauth] = !v
      options[:plain] = !v
    }
    
    opt.on('-P', '--plain', 'Use a plain HTTP request strategy with no auth to connect to Stocktwits.') { |v| 
      options[:plain] = v
      options[:basic] = !v
      options[:oauth] = !v
    }
  end
end
