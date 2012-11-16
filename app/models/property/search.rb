class Property
  class Search < ::Search
    include BasicDocument

    def self.agent_class
      Agent
    end

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
    include_concerns :hasher, :agentize, for: 'Search'

    # belongs_to :agent, class_name: agent_class # 'Property::Agent'

    def hash
      self.class.all_fields.inject(0) {|res, f| res += send(f).hash }
    end  

    def searcher
      @searcher ||= Property::Searcher.new
    end

    def properties
      @properties ||= find_properties
    end

    # Use Searcher!
    def find_properties
      searcher.execute
    end

    protected

    def agent_class
      self.class.agent_class
    end
  end
end