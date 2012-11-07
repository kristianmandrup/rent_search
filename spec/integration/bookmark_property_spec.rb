require 'spec_helper'

describe 'Bookmark properties' do
  subject { tenant.bookmarks }

  context 'a tenant and a property' do
    let(:property) do
      create :valid_property
    end

    let(:property2) do
      create :valid_property
    end

    let(:tenant) do
      create(:tenant_user).account
    end
  
    describe 'Add' do
      describe 'bookmarks <<' do
        before do
          tenant.bookmarks << property.id
        end

        its(:size)  { should == 1}
        its(:first) { should == property.id }
      end

      describe '.bookmark single property' do
        before do
          tenant.bookmark property
        end

        its(:size)  { should == 1}
        its(:first) { should == property.id }
      end

      describe '.bookmark list of properties' do
        before do
          tenant.clear_bookmarks!
          tenant.bookmark property, property2
        end

        its(:size)  { should == 2}
        its(:first) { should == property.id }
      end
    end

    describe 'Remove' do
      describe '.remove_bookmark' do
        before do
          tenant.bookmark property # add
          tenant.remove_bookmark property
        end

        its(:size)  { should == 0}
        its(:first) { should == nil }
      end

      describe '.remove_bookmarks' do
        before do
          tenant.bookmark property, property2, property
          tenant.remove_bookmarks property, property2
        end

        its(:size)  { should == 0}
        its(:first) { should == nil }
      end
    end
  end
end