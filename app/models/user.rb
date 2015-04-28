class User < ActiveRecord::Base

  has_many :user_tokens, inverse_of: :user

  def self.find_or_create_from_auth_hash(auth_hash)
    provider = auth_hash['provider']
    uid = auth_hash['uid']

    # existing user
    if user_token = UserToken.find_by_provider_and_uid(provider, uid)
      return user_token.user
    end

    # see if there is a user for the email address
    email_address = auth_hash['info']['email']
    credentials = auth_hash['credentials']
    if user = find_by_email_address(email_address)
      user.user_tokens.create({
        provider: provider,
        uid: uid,
        token: credentials['token'],
        secret: credentials['secret'],
        refresh: credentials['refresh']
      })
      return user
    end

    # create a new user
    create({
      name: auth_hash['info']['name'],
      email_address: email_address,
      user_tokens: [
        UserToken.new({
          provider: provider,
          uid: uid,
          token: credentials['token'],
          secret: credentials['secret'],
          refresh: credentials['refresh']
        })
      ]
    })
  end


end