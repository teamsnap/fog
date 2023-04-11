require 'fog/core'
require 'fog/xml'

module Fog
  module Google

    extend Fog::Provider

    service(:compute, 'Compute')
    service(:storage, 'Storage')

    # CGI.escape, but without special treatment on spaces
    def self.escape(str,extra_exclude_chars = '')
      # '-' is a special character inside a regex class so it must be first or last.
      # Add extra excludes before the final '-' so it always remains trailing, otherwise
      # an unwanted range is created by mistake.
      str.gsub(/([^a-zA-Z0-9_.#{extra_exclude_chars}-]+)/) do
        "%" + Regexp.last_match(1).unpack("H2" * Regexp.last_match(1).bytesize).join("%").upcase
      end
    end

    class Mock

      def self.etag
        hex(32)
      end

      def self.hex(length)
        max = ('f' * length).to_i(16)
        rand(max).to_s(16)
      end

    end
  end
end
