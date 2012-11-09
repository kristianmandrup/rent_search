class Property
  class Search < ::Search
    include BasicDocument

    # to fine tune name returned for url
    # http://rocketrails.wordpress.com/2011/12/29/urls-for-namespaced-models/

    # semantic_form_for [:admin, @user] do |f|
    # semantic_form_for @user, :url => polymorphic_path( [:admin, @user] ) do |f|

    # http://www.ruby-forum.com/topic/216597
    # polymorphic_path([:admin,@user])
    # polymorphic_path([:admin,:new,@user])
    # <% semantic_form_for polymorphic_path([:admin, @user]) do |form| %>
    #   <%= form.inputs %>
    #   <%= form.buttons %>
    # <% end %>    

    include_concerns :fields
    include_concerns :hasher, for: 'Search'

    belongs_to :agent, class_name: 'Property::Agent'

    def searcher
      @searcher ||= Property::Searcher.new
    end

    def properties
      @properties ||= find_properties
    end

    def create_agent_for user
      Agent.create self, user: user
    end

    # Use Searcher!
    def find_properties
      searcher.execute
    end
  end
end