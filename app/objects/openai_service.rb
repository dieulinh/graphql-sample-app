require 'net/http'
require 'uri'
class OpenaiService
  def call(promp)
    make_post_request('https://api.openai.com/v1/chat/completions', request_promp(promp))
  end
  def request_promp(promp)
    {
      model: "gpt-3.5-turbo",
      messages: [{ role: "system", content: "You are a helpful assistant."},
                 { role: "user", content: promp}]
    }
  end
  private
  def make_post_request(url, body)
    uri = URI.parse(url)
    authorization_header = "Bearer #{ENV['OPENAI_API_KEY']}"
    json_string = body.to_json
    request = Net::HTTP::Post.new(uri,  'Content-Type' => 'application/json', 'Authorization' => authorization_header)

    request.body = json_string

    req_options = {
      use_ssl: uri.scheme == 'https'
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options)  do |http|
      http.request(request)
    end

    puts response.body
  end
end

