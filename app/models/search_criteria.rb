class SearchCriteria
  include BasicDocument
    
  field :rooms,         type: Array
  field :price,         type: Range
  field :size,          type: Range
  field :types,         type: Array # apartment, house
  field :location
  field :region
  field :city
  field :street

  field :year_built,    type: Timespan
  field :published,     type: Timespan

  field :period,        type: Timespan
  field :radius,        type: Integer

  # classy_enum_attr :furnished 

  validates :types,     property_types: true

  def search    
    Property.where criteria
  end

  # query_criteria
  def criteria
    @criteria ||= search_fields.inject({}) do |res, field|
      field_value = self.send(field)
      if field_value
        # puts "field_value: #{field_value.inspect} - class: #{field_value.class}"
        value = case field_value
        when ::Timespan
          field = criteria_field_name(field)          
          res["#{field}.#{TimeSpan.start_field}"] = {'$gte' => field_value.start_date.to_i  }
          res["#{field}.#{TimeSpan.end_field}"]   = {'$lte' => field_value.end_date.to_i    }
          nil
        when Array
          res[criteria_field_name(field)] = {"$in" => field_value }
        when Range
          res[criteria_field_name(field)] = {'$gte' => field_value.first, '$lt' => field_value.last}
        when Hash
          # if field_value[:duration]
        else
          field_value
        end
        res[criteria_field_name(field)] = value if value
      end
      res
    end
  end

  protected

  def criteria_field_name field
    field_name = real_field_name(field)
    address_fields.include?(field_name) ? "address.#{field_name}" : field_name.to_s
  end

  def real_field_name(field)
    case field
    when :period
      'active_rental_period.period'
    else
      field
    end
  end

  def address_fields
    [:region, :city, :street, :country, :zip_code]
  end

  def search_fields
    [:region, :city, :street, :rooms, :cost, :types, :size, :furnishment, :radius, :period]
  end
end