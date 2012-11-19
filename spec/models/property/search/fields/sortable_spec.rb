require 'spec_helper'

class SortableDoc
  include BasicDocument

  include Property::Search::Fields::Sortable
end

describe Property::Search::Fields::Sortable do
  let(:clazz) { SortableDoc }

  def default name
    clazz.criteria_default name
  end

  describe 'Sortable' do
    # TODO: Use factory?
    subject { clazz.create rooms: 1..3, types: ['room', 'apartment'] }

    describe 'asc_fields' do
      specify { clazz.asc_fields.should include('date') }
    end

    describe 'desc_fields' do
      specify { clazz.asc_fields.should include('cost') }
    end
  end
end