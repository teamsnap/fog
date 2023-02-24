require 'fog/core/model'
require 'fog/teamsnap/models/storage/files'

module Fog
  module Storage
    class Teamsnap

      class Directory < Fog::Model
        identity :key, :aliases => ['Name','name']

        def initialize(new_attributes = {})
          puts new_attributes.values.map{|x| x.class.inspect}
          rack_attributes = new_attributes.dup.merge(
            service: new_attributes[:service].rackspace,
            collection: new_attributes[:collection].downstream[:rackspace]
          )
          @downstream = {
            rackspace: Fog::Storage::Rackspace::Directory.new(new_attributes.dup)
          }
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

        def public_url
          @downstream[:rackspace].public_url
        end

        def save
          raise 'not implemented - dir save'
        end
      end

    end
  end
end
