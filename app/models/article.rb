class Article < ApplicationRecord

    # One to many association
    belongs_to :user

    # Many to many association
    has_many :article_categories
    has_many :categories, through: :article_categories

    validates :title, presence: true, length: { minimum: 6, maximum: 100 }
    validates :description, presence: true, length: { minimum: 10, maximum: 300 }
end