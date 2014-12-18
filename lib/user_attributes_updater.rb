require 'open-uri'
require 'json'

module UserAttributesUpdater
  module_function

  GITHUB_API_URL = 'https://api.github.com'

  def update(users, access_token)
    users.each do |user|
      begin
        update_user!(user, access_token: access_token)
      rescue => e
        # TODO: Retry
        warn "Update failed. #{user.inspect} #{e}"
      end
      sleep 10 unless access_token
    end
  end

  def update_user!(user, access_token: nil)
    url = "#{GITHUB_API_URL}/users/#{user.login}"
    url << "?access_token=#{access_token}" if access_token
    attr = JSON(open(url) { |f| f.read })
    user.update_attributes!(name: attr['name'],
                            url: attr['html_url'],
                            avatar_url: attr['avatar_url'],
                            followers: attr['followers'],
                            following: attr['following'])
  end
end
