class User < ApplicationRecord
    before_save { self.email = email.downcase }

    # Many to one association
    has_many :articles, dependent: :destroy
    # dependant: :destroy means if a user is deleted all the articles associated with the user will be deleted as well

    validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }

    # Create a constant to check for valid email regex
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 105 }, format: { with: VALID_EMAIL_REGEX }

    has_secure_password
    
end