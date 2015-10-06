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

module Narra
  module Archiveorg
    module Extensions
      module Parser

        def prepare_proxies
          # get metadata
          arch_metadata = JSON.load(open("https://archive.org/metadata/#{@name}"))
          arch_server = 'http://' + arch_metadata['d1'] + arch_metadata['dir'] + '/'

          # resolve all media
          arch_media = arch_metadata['files'].select { |f| f['source'] == 'original' and f['format'] != 'Metadata' }

          # prepare connectors container
          proxies = []

          # create connectors
          arch_media.each do |item|
            if arch_metadata['metadata']['mediatype'] == 'movies'
              # get thumbnails selection
              selection = arch_metadata['files'].select { |f| f['name'].include?(item['name'].split('.').first) and f['format'] == 'Thumbnail' }.sample
              # pick one
              thumbnail = arch_server + selection['name'] unless selection.nil?
              # generate proxy
              proxies << {
                  url: @uri.to_s,
                  name: item['name'].split('.').first,
                  thumbnail: thumbnail,
                  type: :video,
                  connector: @identifier,
                  author: true,
                  options: @options,
                  @identifier => {
                      arch_server: arch_server,
                      arch_item: item,
                      arch_metadata: arch_metadata['metadata'],
                      type: :video,
                      name: item['name'].split('.').first
                  }
              }
            end
          end

          # return
          proxies
        end
      end
    end
  end
end