module PostgresCommands

  def backup_command(config, destination)
    parts = [ "pg_dump -Fc" ]
    parts.unshift password_env(config)
    parts += command_parts(config)
    parts += [ "-f #{destination}" ]
    parts << "#{config['database']}" if config['database']
    parts.join(' ')
  end
  module_function :backup_command

# RESTORE FULL DATABASE
#pg_restore -h lrd-dev -U postgres -d thefriendex_dev db_backups/frx.pg
  def restore_backup_command(config, source_file)
    parts = [ "pg_restore -c" ]
    parts.unshift password_env(config)
    parts += command_parts(config)
    parts << "-d #{config['database']}" if config['database']
    parts << "#{source_file}"
    parts.join(' ')
  end
  module_function :restore_backup_command

  def save_tables_command(config)
    parts = [ "pg_dump -F c" ]
    parts.unshift password_env(config)
    parts += command_parts(config)
    parts += table_parts(config)
    parts += [ "-f #{DATA_LOCATION}" ]
    parts << "#{config['database']}" if config['database']
    parts.join(' ')
  end
  module_function :save_tables_command


  # DROP DATABASE
  #psql -U postgres -h lrd-dev -c 'drop database thefriendex_dev'
  def wipe_db_command(config)
    parts = [ 'psql postgres' ] #connect to the master database
    parts.unshift password_env(config)
    parts += command_parts(config)
    parts << "-c 'drop database #{config['database']}'"
    parts.join(' ')
  end
  module_function :wipe_db_command

  # CREATE DATABASE
  #createdb -h lrd-dev -U postgres -T template0 thefriendex_dev
  def create_db_command(config)
    parts = [ 'createdb' ]
    parts.unshift password_env(config)
    parts += command_parts(config)
    parts << "-T template0 #{config['database']}"
    parts.join(' ')
  end
  module_function :create_db_command

  #pg_restore -l db_backups/frx.pg  > TOCFILE
  def generate_tocfile(backup_file = 'db_backups/latest.pg', tocfile_name = 'db_backups/tocfile')
    "pg_restore -l #{backup_file} > #{tocfile_name}"
  end
  module_function :generate_tocfile

  # pg_restore -h lrd-dev -U postgres -d thefriendex_dev db_backups/frx.pg -L
  # db_backups/frxtoc
  def load_with_tocfile(config, source_file, tocfile)
    parts = [ "pg_restore" ]
    parts.unshift password_env(config)
    parts += command_parts(config)
    parts << "-d #{config['database']}" if config['database']
    parts << "#{source_file}"
    parts << "-L #{tocfile}"
    parts.join(' ')
  end
  module_function :load_with_tocfile

  def wipe_command(config)
    parts = [ 'psql' ]
    parts.unshift password_env(config)
    parts += command_parts(config)
    parts << "-d #{config['database']}" if config['database']
    parts << "-c '"
    parts << PERSIST_TABLES.map{|t| "DROP TABLE #{t}"}.join('; ')
    parts << "'"
    parts.join(' ')
  end
  module_function :wipe_command

  def load_command(config)
    parts = [ 'pg_restore' ]
    parts.unshift password_env(config)
    parts += command_parts(config)
    parts += table_parts(config)
    parts << "-d #{config['database']}" if config['database']
    parts += [ "#{DATA_LOCATION}" ]
    parts.join(' ')
  end
  module_function :load_command

  def command_parts(config)
    parts = []
    parts << "-U #{config['username']}" if config['username']
    parts << "-h #{config['host']}" if config['host']
  end
  module_function :command_parts

  def password_env(config)
    "PGPASSWORD='#{config['password']}'" if config['password']
  end
  module_function :password_env

  def table_parts(config)
    parts = []
    PERSIST_TABLES.each do |tablename|
      parts << "-t #{tablename}"
    end
    parts
  end
  module_function :table_parts
end


