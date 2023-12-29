module GetDuplicates
  def self.execute(json_array:)
    return [] if json_array.empty?

    email_group = json_array.group_by{ |json| json[:email] }
    counts = email_group.map { |value, group| [value, group.map { |json| json[:id] }]}

    counts.select { |key, value| value.length > 1 }
  end
end
