class Article < ApplicationRecord
  extend Enumerize
  enumerize :status, in: [:pending, :rejected, :published], default: :pending
  belongs_to :user
end
