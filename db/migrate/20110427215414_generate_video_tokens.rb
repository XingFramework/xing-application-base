class GenerateVideoTokens < ActiveRecord::Migration
  def self.up
    Video.where("token is null").map{|v| v.generate_token; v.generate_filename; v.save}
  end

  def self.down
  end
end
