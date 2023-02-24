require 'fog/core/model'

module Fog
  module Storage
    class Teamsnap

      class File < Fog::Model
        def initialize(attributes = {})
          raise 'Attempted to construct a Teamsnap file'
        end
      end
    end
  end
end
