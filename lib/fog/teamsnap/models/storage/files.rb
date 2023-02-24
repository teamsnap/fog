require 'fog/core/collection'
require 'fog/teamsnap/models/storage/file'

module Fog
  module Storage
    class Teamsnap

      class Files < Array
        attr_reader :service
        attr_reader :rackspace

        def initialize(attributes={})
          @service = attributes.delete(:service)
          @directory = attributes.delete(:directory)

          @rackspace = Fog::Storage::Rackspace::Files.new(
            :directory    => @directory,
            :service   => service.rackspace
          )

          @attrs = attributes
        end

        def head(key, options={})
          rackspace.head(key, options)
        end

        def new(attributes = {})
          rackspace.new(attributes)
        end

        def get(key, &block)
          rackspace.get(key, &block)
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
