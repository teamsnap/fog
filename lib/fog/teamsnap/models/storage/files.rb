require 'fog/core/collection'
require 'fog/teamsnap/models/storage/file'

module Fog
  module Storage
    class Teamsnap

      class Files < Array
        attr_reader :service

        def initialize(attributes={})
          @service = attributes.delete(:service)
          @directory = attributes.delete(:directory)
          @downstream = {
            rackspace: Fog::Storage::Rackspace::Files.new(
              :directory    => @directory,
              :service   => service.rackspace
            )
          }
          puts @directory.class.inspect
          @attrs = attributes
        end

        def head(key, options={})
          @downstream[:rackspace].head(key, options)
        end

        def new(attributes = {})
          @downstream[:rackspace].new(attributes)
        end

        def get(key, &block)
          @downstream[:rackspace].get(key, &block)
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
