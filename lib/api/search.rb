class Search < Api

  include HTTParty

  def call(search_term)
    # query = "name=#{URI::encode(search_term)}"
    # uri = URI("#{BASE_URL}/search/series")
    # uri.query = query
    # http = http_client(uri)
    # req = Net::HTTP::Get.new(uri.path)
    # req.add_field 'Authorization', "Bearer #{token}"
    # req.add_field 'Accept', 'application/json'
    # req.add_field 'method', 'GET'
    # response = http.request(req)
    response = self.class.get("#{BASE_URL}/search/series", {
      headers: {'Authorization' => "Bearer #{token}", 'Accept' => 'application/json'},
      query: { name: search_term }
    })
  end

end
