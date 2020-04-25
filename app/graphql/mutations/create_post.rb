module Mutations
  class CreatePost < BaseMutation
    argument :title, String, required: true
    argument :content, String, required: true
    argument :published, Boolean, required: false

    type Types::PostType
    def resolve(title: nil, content: nil, published: false)
      Post.create!(title: title, content: content, published: published)
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(", ")}")
    end
  end
end
