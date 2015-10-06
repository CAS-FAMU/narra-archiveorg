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
      module Metadata

        def prepare_metadata
          # prepare metadata
          metadata = []

          # parse archive.org item metadata
          metadata << {name: 'title', value: @options[:arch_item]['title']}
          metadata << {name: 'crc32', value: @options[:arch_item]['crc32']}
          metadata << {name: 'sha1', value: @options[:arch_item]['sha1']}

          # parse archive.org collection metadata
          metadata << {name: 'mediatype', value: @options[:arch_metadata]['mediatype']}
          metadata << {name: 'collection', value: @options[:arch_metadata]['collection']}
          metadata << {name: 'group', value: @options[:arch_metadata]['title']}
          metadata << {name: 'description', value: @options[:arch_metadata]['description']}
          metadata << {name: 'subject', value: @options[:arch_metadata]['subject']}
          metadata << {name: 'identifier', value: @options[:arch_metadata]['identifier']}
          metadata << {name: 'uploader', value: @options[:arch_metadata]['uploader']}

          # author parse
          if @options[:arch_metadata]['creator']
            metadata << {name: 'author', value: @options[:arch_metadata]['creator']}
          else
            metadata << {name: 'author', value: @options[:arch_metadata]['uploader']}
          end

          # generate keywords from subject
          subject = @options[:arch_metadata]['subject']
          # generate keywords
          unless subject.nil?
            if subject.include?(',')
              keywords = subject.split(',').collect { |item| item.strip }
            elsif sibject.include?(';')
              keywords = subject.split(';')
            else
              keywords = subject.split
            end
            # add keywords meta
            metadata << {name: 'keywords', value: keywords}
          end

          # update metatada
          @metadata = metadata
        end
      end
    end
  end
end