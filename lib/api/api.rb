class Api

  API_KEY = 'VGY0XIHVT52KD85J'
  USERNAME = 'bhanuone43s5n'
  USERKEY = 'T56RSXQAKX3F60F4'
  BASE_URL = 'https://api.thetvdb.com'

  def initialize
    @token = nil
  end


  protected

  def get_token
    uri = URI("#{BASE_URL}/login")
    http = http_client(uri)
    req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    req.body = { apikey: API_KEY, username: USERNAME, userkey: USERKEY }.to_json
    response = http.request(req)
    @token = JSON.parse(response.body)['token']
  end

  def refresh_token
    uri = URI("#{BASE_URL}/refresh_token")
    http = http_client(uri)
    req = Net::HTTP::Get.new(uri.path)
    req.add_field 'Authorization', "Bearer #{token}"
    response = http.request(req)
    @token =  JSON.parse(response.body)['token']
  end

  def http_client(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http
  end

  def token
    @token || get_token 
  end
  
end