class Property::Search < BaseSearch
  module Geo
    extend ActiveSupport::Concern

    def calc_point address
      result = ::Geocoder.search(address)[0]
      raise Property::Search::GeoCodeError, "No geo location could be found for address: #{address}" if result.nil?
      [result.longitude, result.latitude]
    end
  end
end