json.array!(@restaurants) do |restaurant|
  json.extract! restaurant, :id, :name, :email, :address, :latitude, :longitude
  json.url restaurant_url(restaurant, format: :json)
end
