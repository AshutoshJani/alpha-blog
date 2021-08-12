class Category < ApplicationRecord

    has_many :article_categories
    has_many :articles, through: :article_categories

    validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }
    # validates_uniqueness_of :name #this can used as well to test for uniqueness

end