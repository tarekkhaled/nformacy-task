class ArticleSerializer
  include JSONAPI::Serializer

  attributes :id, :title, :description, :status

  attribute :user, Proc.new { |record|
    record.user&.full_name
  }
end
