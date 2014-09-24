class DeadbeatConnectionRelease
  def initialize(app)
    @app = app
  end

  #This is a brittle hack for what appears to be a bug in ActiveRecord 4:
  #connections aren't being properly released after their owning threads die
  def call(env)
    response = @app.call(env)
    response[2] = ::Rack::BodyProxy.new(response[2]) do
      ActiveRecord::Base.connection_handler.connection_pool_list.each do |pool|
        reservers = pool.instance_variable_get("@reserved_connections").keys
        deadbeats = reservers - Thread.list.map(&:object_id)
        Rails.logger.info{ "Releasing connections held by these no-longer-living Threads: #{deadbeats}" } unless deadbeats.empty?
        deadbeats.each do |deadbeat_id|
          pool.release_connection(deadbeat_id)
        end
      end
    end

    response
  end
end
