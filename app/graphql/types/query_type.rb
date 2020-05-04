module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    field :all_posts, [PostType], null: false

    def all_posts(**_args)
      Post.all
    end

    field :posts_connection, Types::PostType.connection_type, null: false
    def posts_connection(**_args)
      Post.all
    end

    field :courses_connection, Types::CourseType.connection_type, null: false
    def courses_connection(**_args)
      Course.all
    end
  end
end
