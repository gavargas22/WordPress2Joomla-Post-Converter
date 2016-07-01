json.array!(@connections) do |connection|
  json.extract! connection, :id, :db_name, :db_host, :db_username, :db_password
  json.url connection_url(connection, format: :json)
end
