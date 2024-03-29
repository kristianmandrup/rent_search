source "http://rubygems.org"

gemspec

# SEARCH
gem 'fast-stemmer' # only English
gem 'mongoid_search', '>= 0.3.0', github: 'mauriciozaffari/mongoid_search'
# gem 'mongoid_fulltext' # https://github.com/artsy/mongoid_fulltext
gem 'ruby-stemmer', require: 'lingua/stemmer'

gem 'rent_core',     path: '/Users/kmandrup/private/repos/company/engines/rent_core'
gem 'rent_property', path: '/Users/kmandrup/private/repos/company/engines/rent_property'

gem 'sugar-high', '~> 0.7.3', path: '/Users/kmandrup/private/repos/sugar-high' # for range intersect

# INFRA
gem 'mongoid',  '>= 3.0'
gem 'concerned',  '~> 0.1.4'
gem 'rails_config_loader',  '~> 0.1.4'

gem 'ajaxify_rails'

gem 'RubyDataStructures', path: '/Users/kmandrup/private/repos/Ruby-Data-Structures' # github: 'kristianmandrup/Ruby-Data-Structures'

# gem 'ms-dropdown-rails'

# DATA
gem 'classy_enum', path: '/Users/kmandrup/private/repos/classy_enum' # git: 'git://github.com/kristianmandrup/classy_enum.git'
gem 'classy_enum-mongoid', github: 'kristianmandrup/classy_enum-mongoid'

gem 'kaminari'

gem 'origin-selectable_ext'
gem 'timespan', '~> 0.5.2', path: '/Users/kmandrup/private/repos/timespan'
gem 'phone', '~> 1.1', github: 'kristianmandrup/phone'

# VALIDATORS
gem "validators"
gem "rails-validators", '~> 0.1.1', github: 'kristianmandrup/rails-validators'
gem 'validates_timeliness'

gem 'gmaps4rails', :path => '/Users/kmandrup/private/repos/Google-Maps-for-Rails'

gem 'rgeo'

gem 'redis' # for caching

gem 'geo_calc'
gem 'geo_point'
gem 'geo_vectors'

gem 'geocoder' #, :path => '/Users/kmandrup/private/repos/geocoder' # :git => 'git://github.com/kristianmandrup/geocoder.git', :branch => 'mongoid_geospatial'
gem 'mongoid_geospatial', '>= 2.7.0', github: 'kristianmandrup/mongoid_geospatial'

gem 'dbf'
gem 'georuby'
gem 'geonames_local', github: 'nofxx/geonames_local' # Downloads and store Geonames.org data locally

# Enums for mongoid!
gem 'symbolize', '~> 4.2', github: 'nofxx/symbolize'
gem 'sorcery', path: '/Users/kmandrup/private/repos/sorcery' # github: 'kristianmandrup/sorcery'
gem 'stringex', path: '/Users/kmandrup/private/repos/stringex' #github: 'kristianmandrup/stringex'

gem 'simple_range_validator', '~> 0.2.1'

gem 'mongoid_rateable', github: 'kristianmandrup/mongoid_rateable'

gem 'rails-gallery',  '>= 0.3.0', path: '/Users/kmandrup/private/repos/rails-gallery-themed'

# UI
gem 'apotomo', '~> 1.2.3', path: '/Users/kmandrup/private/repos/apotomo' # git: 'git://github.com/kristianmandrup/apotomo.git' 

gem 'draper', github: 'drapergem/draper'

gem 'decent_exposure', github: 'voxdolo/decent_exposure'

gem 'formtastic'
gem 'haml'
gem "jquery-rails"
gem 'jquery_ui_rails_helpers', path: '/Users/kmandrup/private/repos/jquery-ui-rails-helpers'

require File.dirname(__FILE__) + '/lib/rent_search/gem_butler'

butler = GemButler.new File.dirname(__FILE__) + '/gemfiles'
# butler.include_only :names => [:geo, :data_store, :mongoid, :util]
butler.print_gemfile_names

butler.filtered.each do |gemfile|
  eval(IO.read(gemfile), binding)
end



