# Version control
require "atomized_social/version"

# Exceptions
require "atomized_social/exceptions/unsupported_network_error"
require "atomized_social/exceptions/bad_authentication_error"

# Networks
require "atomized_social/authentication/twitter"
require "atomized_social/authentication/facebook"
require "atomized_social/authentication/instagram"
require "atomized_social/authentication/youtube"
require "atomized_social/authentication/linkedin"

# 3rd party gems
require "pry"
require "oauth"

class AtomizedSocial
  def authenticate(network, params)
    # Make sure we have minimal data to authenticate
    raise ArgumentError if network.nil? || params.nil? || params[:callback_url].nil? || params[:secret].nil? || params[:key].nil?

    # Convert to symbol if isn't one
    network = network.to_sym unless network.is_a? Symbol

    # Get the correct class to authenticate against
    oauth_network = case network
    when :twitter
        AtomizedSocial::Authentication::Twitter.new(params[:key], params[:secret])
      when :facebook
        AtomizedSocial::Authentication::Facebook.new(params[:key], params[:secret])
      when :instagram
        AtomizedSocial::Authentication::Instagram.new(params[:key], params[:secret])
      when :youtube
        AtomizedSocial::Authentication::Youtube.new(params[:key], params[:secret])
      when :linkedin
        AtomizedSocial::Authentication::Linkedin.new(params[:key], params[:secret])
      else
        raise AtomizedSocial::Exceptions::UnsupportedNetworkError
    end

    # Make call to authenticate
    response = oauth_network.authenticate(params)
  end
end
