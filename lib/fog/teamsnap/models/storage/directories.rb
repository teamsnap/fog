require 'fog/core/collection'
require 'fog/teamsnap/models/storage/directory'

module Fog
  module Storage
    class Teamsnap

      class Directories < Fog::Collection
        model Fog::Storage::Teamsnap::Directory
        attr_reader :google, :rackspace

        def initialize(attributes = {})
          @google = Fog::Storage::Google::Directories.new(
            attributes.dup.merge(service: attributes[:service].google)
          )
          @rackspace = Fog::Storage::Rackspace::Directories.new(
            attributes.dup.merge(service: attributes[:service].rackspace)
          )
          super(attributes)
        end
      end

    end
  end
end
