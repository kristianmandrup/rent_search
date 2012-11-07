class Property
  class SearchOptions
    def initialize
    end

    def options name
      meth = "#{name}_options"
      raise ArgumentError, "No Search options defined for #{name}" unless respond_to? meth
      send(meth) 
    end

    def self.search_options
      [:radius, :rooms, :size, :cost, :rentability, :rating]
    end

    protected

    search_options.each do |name|
      define_method "#{name}_options" do
        any = { 'any' => I18n.t("search_form.#{name}.options.any") }
        begin
          unit = I18n.translate! "search_form.#{name}.unit"
        rescue I18n::MissingTranslationData
          unit = ''
        end
        hash = I18n.t("search_form.#{name}.options.choice").inject(any) do |res, choice|
          key = res.size.to_s
          label = [choice, unit].compact.join(' ')
          res.merge! key => label
        end
      end
    end

    def type_options
      I18n.t("search_form.type.options")
    end

    def furnishment_options
      I18n.t("search_form.furnishment.options")
    end
  end
end
