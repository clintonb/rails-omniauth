require 'typhoeus'

class User < ActiveRecord::Base

  def self.create_with_omniauth(auth)
    create! do |user|
      # TODO: Store the provider-UID association, and the access token in a many-to-many join table.
      user.access_token = auth.credentials.token

      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
        user.name = auth['info']['name'] || ""
      end
    end
  end

  def enrollments
    # Returns active enrollments for the user
    response = Typhoeus.get('https://courses.stage.edx.org/api/enrollment/v1/enrollment', headers: {'Authorization': "Bearer #{self.access_token}"})
    JSON.parse(response.body)
  end

end
