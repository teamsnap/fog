require 'fog/teamsnap/core'

module Fog
  module Storage
    class Teamsnap < Fog::Service
      requires :rackspace_api_key, :rackspace_username
      recognizes :rackspace_auth_url, :rackspace_servicenet, :rackspace_cdn_ssl, :persistent, :rackspace_region
      recognizes :rackspace_temp_url_key, :rackspace_storage_url, :rackspace_cdn_url

      model_path 'fog/teamsnap/models/storage'
      model       :directory
      collection  :directories

      class Real < Fog::Teamsnap::Service
        attr_accessor :rackspace

        def initialize(options={})
          @rackspace = Fog::Storage::Rackspace.new(options)
        end

        def reload
          @rackspace.reload
        end

        def cdn
          @rackspace.cdn
        end

        def ssl?
          @rackspace.ssl?
        end
      end
    end
  end
end
