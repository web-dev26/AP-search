json.array!(@isearches) do |isearch|
  json.extract! isearch, :id
  json.url isearch_url(isearch, format: :json)
end
