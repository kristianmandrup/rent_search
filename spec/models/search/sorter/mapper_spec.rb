require 'spec_helper'

describe Search::Sorter::Mapper do
  subject { mapper }

  let(:mapper) { Search::Sorter::Mapper.new }

  let(:sort_field) { :cost } 
  let(:sort_direction) { :desc }

  # TODO: Not working - Use Search::Sorting::Mapper to parse and map
  describe 'map!' do
    pending 'TODO'
  end
end
