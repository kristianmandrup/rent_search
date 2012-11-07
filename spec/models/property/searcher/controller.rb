module Searcher
  module Controller
    def searcher
      @searcher ||= Property::Searcher.new searcher_hash.merge(order: order, page: page)
    end

    def sort_param
      param_for(:sort) || 'created_at::asc'
    end

    def sort_params
       sort_param.split('::')
    end

    def order
      sort_params.first
    end

    def direction
      sort_params.last
    end

    def page
      params[:page]
    end

    def searcher_hash
      fields.inject({}) do |res, field|
        # raise "Unknown search field: #{field}" 
        if param_for(field)
          res.merge! field.to_sym => param_for(field)
        end
      end
    end

    def param_for name
      search_hash[name]
    end

    def search_hash
      params[:search]
    end

    def fields
      %w{radius location furnishment rooms type size cost rating rentability}
    end      
  end
end