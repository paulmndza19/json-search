module Search
  def self.execute(query_string:, json_array:, json_key:)
    return [] if json_array.empty?

    json_array.select { |json| json[json_key].downcase.include? query_string }
  end
end
