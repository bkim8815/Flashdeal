json.array!(@customers) do |customer|
  json.extract! customer, :id, :phone_number, :latitude, :longitude
  json.url customer_url(customer, format: :json)
end
