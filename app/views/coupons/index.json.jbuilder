json.array!(@coupons) do |coupon|
  json.extract! coupon, :id, :title, :price, :start_time, :end_time, :expiration, :max_count, :Restaurant_id
  json.url coupon_url(coupon, format: :json)
end
