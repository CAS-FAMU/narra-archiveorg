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

require 'spec_helper'

describe Narra::Archiveorg::Connector do
  before(:each) do
    # create metadata
    @url = 'https://archive.org/details/movies'
    @options = {arch_server: '', arch_item: { 'name' => ''}, arch_metadata: {}}
  end

  it 'can be instantiated' do
    expect(Narra::Archiveorg::Connector.new(@url, @options)).to be_an_instance_of(Narra::Archiveorg::Connector)
  end

  it 'should be properly registered' do
    expect(Narra::Core.connectors).to include(Narra::Archiveorg::Connector)
  end

  it 'should validate items' do
    expect(Narra::Archiveorg::Connector.valid?(@url)).to match(true)
    expect(Narra::Archiveorg::Connector.valid?('')).to match(false)
  end
end
