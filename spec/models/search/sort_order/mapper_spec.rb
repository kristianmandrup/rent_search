require 'spec_helper'

describe BaseSearch::SortOrder::Calculator::Mapper do
  subject { mapper }

  let(:mapper) { BaseSearch::SortOrder::Calculator::Mapper.new }

  let(:sort_field) { :cost } 
  let(:sort_direction) { :desc }

  # TODO: Not working - Use Search::Sorting::Mapper to parse and map
  describe 'map!' do
    pending 'TODO'
  end
end
