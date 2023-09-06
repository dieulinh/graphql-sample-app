class OpenAiPrompt < Grape::API

  namespace :prompts do
    params do
      requires :content, type: String
      requires :prompt_salt, type: String
    end
    post '/' do
      return {error: :invalid} unless Base64.decode64(params[:prompt_salt]).strip == ENV['OPENAI_PROMPT_SALT']
      rs = openai_service.call(params[:content])
      { result: rs }
    end

    post '/generate-lessons' do
      return {error: :invalid} unless Base64.decode64(params[:prompt_salt]).strip == ENV['OPENAI_PROMPT_SALT']
      rs = openai_service.call(params[:content])
      { result: rs }
    end
  end
end