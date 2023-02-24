require 'fog/core'
require 'fog/teamsnap/service'

module Fog
  module Teamsnap
    extend Fog::Provider

    service(:storage, 'Storage')
  end
end
