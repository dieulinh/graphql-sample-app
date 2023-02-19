class Resumes < Grape::API
  include Shared::AuthorizationKit
  namespace :resumes do
    params do
      requires :content, type: String
    end
    post '/' do
      client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
      prompt = params[:content]
      response = client.completions(
          parameters: {
            model: "text-davinci-003",
            prompt: prompt,
            max_tokens: 2000
          })

      # puts response['choices'][0]['text']
      present response['choices'][0]['text']
    end
  end
end


# write me a resume for a web developer with 5 years working as nodejs backend developer
