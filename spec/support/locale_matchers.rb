module Danish
  def self.zipcode
    /\d{4}/
  end

  def self.email
    /@/
  end
end

module USA
  def self.zipcode
    /\d{5}-\d{4}/
  end
end
