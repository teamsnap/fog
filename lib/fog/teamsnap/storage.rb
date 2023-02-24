require 'fog/teamsnap/core'

module Fog
  module Storage
    class Teamsnap < Fog::Service
      requires :rackspace_api_key, :rackspace_username
      recognizes :rackspace_auth_url, :rackspace_servicenet, :rackspace_cdn_ssl, :persistent, :rackspace_region
      recognizes :rackspace_temp_url_key, :rackspace_storage_url, :rackspace_cdn_url

      requires :google_storage_access_key_id, :google_storage_secret_access_key

      model_path 'fog/teamsnap/models/storage'
      model       :directory
      collection  :directories

      class Real < Fog::Teamsnap::Service
        attr_accessor :google, :rackspace

        def initialize(options={})
          @google = Fog::Storage::Google.new(options.dup.delete_if{|k,v| k.to_s =~ /rackspace/})
          @rackspace = Fog::Storage::Rackspace.new(options.dup.delete_if{|k,v| k.to_s =~ /google/})
        end

        def reload
          @google.reload
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
