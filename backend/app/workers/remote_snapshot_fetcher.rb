require 'snapshot_writing'

class RemoteSnapshotFetcher
  include Sidekiq::Worker
  include SnapshotWriting

  def perform(url, path)
    admin_server = Rails.application.secrets.snapshot_server['url']
    user_password = "#{Rails.application.secrets.snapshot_server['user']}:#{Rails.application.secrets.snapshot_server['password']}"
    snapshot_url = url + path
    request = Typhoeus::Request.new(admin_server,
      userpwd: user_password,
      params: {
        url: snapshot_url
      }
    )

    hydra = Typhoeus::Hydra.new
    hydra.queue(request)
    hydra.run

    response = request.response

    html = response.body
    write(path, html)
  end

end
