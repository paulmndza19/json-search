require 'minitest/autorun'
require_relative '../lib/get_duplicates'
require 'json'

describe GetDuplicates do
  it 'returns a 3 dimensional array when there are duplicates' do
    file_path = './test_clients.json'
    file = File.read(file_path)
    json_array = JSON.parse(file).map{|hash| hash.transform_keys(&:to_sym) }

    duplicates = GetDuplicates.execute(json_array: json_array)

    assert_equal 'jane.smith@yahoo.com', duplicates[0][0]
    assert_equal [2, 15], duplicates[0][1]
  end

  it 'returns an empty array when there are no duplicates' do
    json_array = [
      {
      "id": 1,
      "full_name": "John Doe",
      "email": "john.doe@gmail.com"
      },
      {
        "id": 2,
        "full_name": "Jane Smith",
        "email": "jane.smith@yahoo.com"
      }
    ]
    duplicates = GetDuplicates.execute(json_array: json_array)

    assert_equal [], duplicates
  end

  it 'returns an empty array when json_array is also empty' do
    duplicates = GetDuplicates.execute(json_array: [])

    assert_equal [], duplicates
  end
end
