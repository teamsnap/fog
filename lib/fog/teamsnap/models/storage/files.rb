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
          google.head(key, options)
          #rackspace.head(key, options)
        end

        def new(attributes = {})
          google.new(attributes)
          #rackspace.new(attributes)
        end

        def get(key, &block)
          google.get(key, &block)
          #rackspace.get(key, &block)
        end

        def create(attributes = {})
          object = new(attributes)
          object.save
          object
        end
      end

    end
  end
end
