require 'fog/core/collection'
require 'fog/teamsnap/models/storage/file'

module Fog
  module Storage
    class Teamsnap

      class Files < Array
        attr_reader :google, :rackspace

        def initialize(attributes={})
          service = attributes.delete(:service)
          directory = attributes.delete(:directory)

          @google = Fog::Storage::Google::Files.new(
            :directory    => directory.google,
            :service   => service.google
          )

          @rackspace = Fog::Storage::Rackspace::Files.new(
            :directory    => directory.rackspace,
            :service   => service.rackspace
          )

          @attrs = attributes
        end

        def head(key, options={})
          google.head(google_key(key), options)
        end

        def new(attributes = {})
          google.new(google_attrs(attributes))
        end

        def get(key, &block)
          google.get(google_key(key), &block)
        end

        def create(attributes = {})
          object = new(attributes)
          object.save
          object
        end

        private
        # remove the first folder from the path
        def google_attrs(attrs)
          google_attrs = attrs.dup
          return google_attrs.merge(key: google_key(attrs[:key])) if attrs[:key]

          google_attrs
        end

        # remove the first folder from the path
        def google_key(key)
          key.sub(/^\/?[^\/]+\/?/,'')
        end
      end

    end
  end
end
