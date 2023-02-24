require 'fog/core/collection'
require 'fog/teamsnap/models/storage/directory'

module Fog
  module Storage
    class Teamsnap

      class Directories < Fog::Collection
        model Fog::Storage::Teamsnap::Directory
        attr_reader :downstream

        def initialize(attributes = {})
          rack_attributes = attributes.dup.merge(service: attributes[:service].rackspace)
          @downstream = {
            rackspace: Fog::Storage::Rackspace::Directories.new(rack_attributes)
          }
          super(attributes)
        end
      end

    end
  end
end
