require 'minitest/autorun'
require_relative '../lib/search'
require 'json'

describe Search do
  it 'returns a filtered version of the original json array' do
    file_path = './clients.json'
    file = File.read(file_path)
    json_array = JSON.parse(file).map{|hash| hash.transform_keys(&:to_sym) }

    results = Search.execute(query_string: "yan", json_array: json_array, json_key: :email)

    assert_equal 8, results.first[:id]
    assert_equal 1, results.length
  end

  it 'returns an empty array when search result is empty' do
    json_array = [
      {
        id: 1,
        full_name: "John Doe",
        email: "john.doe@gmail.com"
      },
      {
        id: 2,
        full_name: "Jane Smith",
        email: "jane.smith@yahoo.com"
      }
    ]
    results = Search.execute(query_string: "yan", json_array: json_array, json_key: :email)

    assert_equal [], results
  end

  it 'returns an empty array when json_array is also empty' do
    results = Search.execute(query_string: "yan", json_array: [], json_key: "email")

    assert_equal [], results
  end
end
