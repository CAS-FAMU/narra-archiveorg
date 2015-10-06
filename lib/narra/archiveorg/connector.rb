#
# Copyright (C) 2015 CAS / FAMU
#
# This file is part of Narra Core.
#
# Narra Core is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Narra Core is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Narra Core. If not, see <http://www.gnu.org/licenses/>.
#
# Authors: Michal Mocnak <michal@marigan.net>
#

require 'uri'

require 'narra/spi'

require 'narra/archiveorg/options'
require 'narra/archiveorg/extensions/metadata'
require 'narra/archiveorg/extensions/parser'

module Narra
  module Archiveorg
    class Connector < Narra::SPI::Connector

      include Narra::Archiveorg::Extensions::Metadata
      include Narra::Archiveorg::Extensions::Parser

      # Set title and description fields
      @identifier = :archiveorg
      @title = 'Archive.org Connector'
      @description = 'NARRA Archive.org Connector uses json API'
      @options = Narra::Archiveorg::OPTIONS

      def self.valid?(url)
        url.include?('archive.org')
      end

      def self.resolve(url)
        # parse url
        @uri = URI.parse(url)
        @name = File.basename(@uri.path).split('.').first
        # prepares proxies
        prepare_proxies
      end

      def initialization
        # prepare download url
        @download_url = @options[:arch_server] + @options[:arch_item]['name']
        # prepare metadata
        prepare_metadata
      end

      def name
        @options[:name]
      end

      def type
        @options[:type].to_sym
      end

      def metadata
        @metadata
      end

      def download_url
        @download_url
      end
    end
  end
end