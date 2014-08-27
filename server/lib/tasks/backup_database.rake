require 'postgres_commands'
require 'database_config'
require 'backup_utilities'

BACKUP_DIR = Rails.root + 'db_backups'

# DROP DATABASE
#psql -U postgres -h lrd-dev -c 'drop database thefriendex_dev'

# CREATE DATABASE
#createdb -h lrd-dev -U postgres -T template0 thefriendex_dev

# RESTORE FULL DATABASE
#pg_restore -h lrd-dev -U postgres -d thefriendex_dev db_backups/frx.pg

# BACKUP DATABASE WITH TOC
# <backup database, is already correct below>

# RESTORE only pages and categories
# pg_restore -l db_backups/frx.pg  > TOCFILE
#
# <edit tocfile to comment out all TABLE DATA lines except:
#   [ geometry_columns, pages, categories, schema_migrations, spacial_ref_sys ]
# pg_restore -h lrd-dev -U postgres -d thefriendex_dev db_backups/frx.pg -L db_backups/frxtoc

namespace :db do
  namespace :backups do


    # Defaults to production environment
    # call with arg like  'rake db:backups:cycle[development]'
    # for development (or other) environment
    desc "Create a new backup and purge old ones"
    task :cycle, [ :env ] => [
      "db:backups:create",
      "db:backups:purge"
    ]

    desc "Remove excess backups, keeping hourlies for 3 days and dailies for one month"
    task :purge do
      BackupUtilities.purge_excess_backups(BACKUP_DIR)
    end

    # defaults to development enviroment
    # call with env like  'RAILS_ENV=production rake db:backups:restore'
    # for production (or other) environment
    desc "backup the database"
    task :create, [:dir, :filename] do |t, args|
      puts "args were #{args}"
      env = ENV['RAILS_ENV'] || 'development'
      dir = args[:dir] || ENV['DIR'] || BACKUP_DIR
      db_config = DatabaseConfig::read

      if args[:filename]
        filename = "#{dir}/#{args[:filename]}"
      end

      filename ||= "#{dir}/#{db_config['database']}_#{Time.now.strftime('%Y-%m-%d_%H:%M')}.pg"

      system("mkdir -p #{dir}/")

      cmd = PostgresCommands.backup_command(db_config, filename)
      puts "Running command: " + cmd
      system(cmd)
      system "gzip #{filename}"
      system "ln -sfn #{filename}.gz #{dir}/latest.pg.gz"
    end

    # defaults to development enviroment
    # call with env like  'RAILS_ENV=production rake db:backups:restore'
    # for production (or other) environment
    desc 'restore the database backup, defaults to development db'
    task :restore, [:file] do |t, args|
      env = ENV['RAILS_ENV'] || 'development'
      filename = args[:file] || ENV['BACKUP_FILE']

      # If a name wasn't passed, try to use the most recent backup in the
      # standard dir.
      unless filename
        filename = "#{BACKUP_DIR}/" + Dir.new(BACKUP_DIR).find { |f| ['latest.pg.gz', 'latest.pg'].include?(f) }
      end
      require 'pathname'
      filename = Pathname.new(filename).realpath

      # uncompress to a temp file, if it's gzipped
      if filename.to_s =~ /\.gz$/
       tmpfile = Tempfile.new('db')
       system "gunzip -c #{filename} > #{tmpfile.path}"
       filename = tmpfile.path
      end
      p "filename is" => filename
      db_config = DatabaseConfig::read
      p "wipe command: #{PostgresCommands.wipe_db_command(db_config)}"
      system(PostgresCommands.wipe_db_command(db_config))
      system(PostgresCommands.create_db_command(db_config))
      cmd = PostgresCommands.restore_backup_command(db_config, filename)
      puts "Running command: " + cmd
      system(cmd)
      tmpfile.unlink if  defined?(tmpfile)
    end

    desc "Load only persistent tables"
    task :restore_only_persistent_data  do
      backup_dir = Rails.root + '/db_backups'
      db_file = ENV['DB_FILE'] ||  "#{BACKUP_DIR}/latest.pg"
      tocfile = "#{BACKUP_DIR}/tocfile"
      system(PostgresCommands.generate_tocfile(db_file, tocfile))

      # <edit tocfile to comment out all TABLE DATA lines except:
      #   [ geometry_columns, pages, categories, schema_migrations, spacial_ref_sys ]
      keep_tables = [ /geometry_columns/, / pages /, / categories /, /schema_migrations/, /spacial_ref_sys/ ]
      lines = IO.readlines(tocfile).map do |line|
        if line =~ /TABLE DATA/ and (! keep_tables.any?{ |rx| line =~ rx })
          '#' + line
        else
          line
        end
      end
      File.open(tocfile, 'w') do |file|
        file.puts lines
      end

      db_config = DatabaseConfig::read
      system(PostgresCommands.wipe_db_command(db_config))
      system(PostgresCommands.create_db_command(db_config))
      system(PostgresCommands.load_with_tocfile(db_config, db_file, tocfile))
    end

  end
end


