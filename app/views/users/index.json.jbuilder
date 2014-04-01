json.array!(@users) do |user|
  json.extract! user, :id, :username, :name, :email, :phone, :city, :state, :zip
  json.url user_url(user, format: :json)
end
