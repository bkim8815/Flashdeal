json.array!(@phones) do |phone|
  json.extract! phone, :id, :mobile
  json.url phone_url(phone, format: :json)
end
