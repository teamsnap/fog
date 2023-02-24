require 'fog/core/model'
require 'fog/teamsnap/models/storage/files'

module Fog
  module Storage
    class Teamsnap

      class Directory < Fog::Model
        attr_reader :google, :rackspace
        identity :key, :aliases => ['Name','name']

        def initialize(new_attributes = {})
          keys = new_attributes[:key].split('|')
          raise 'Expected fog_directory to be of format RACK_CDN|GCS_BUCKET' unless keys.size == 2

          @google = Fog::Storage::Google::Directory.new(
            new_attributes.dup.merge(
              service: new_attributes[:service].google,
              collection: new_attributes[:collection].google,
              key: keys.last
            )
          )

          @rackspace = Fog::Storage::Rackspace::Directory.new(
            new_attributes.dup.merge(
              service: new_attributes[:service].rackspace,
              collection: new_attributes[:collection].rackspace,
              key: keys.first
            )
          )

          super(new_attributes)
        end

        def destroy
          raise 'not implemented - dir destroy'
        end

        def files
          @files ||= begin
            Fog::Storage::Teamsnap::Files.new(
              :directory    => self,
              :service   => service
            )
          end
        end

        def save
          raise 'not implemented - dir save'
        end
      end

    end
  end
end
