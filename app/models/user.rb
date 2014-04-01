class User < ActiveRecord::Base
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    # Username validation
    validates :username,
        presence: true,
        uniqueness: { case_sensitive: false }
    
    # Email validattion
    validates :email,
        presence: true,
        format: { with: VALID_EMAIL_REGEX },
        uniqueness: { case_sensitive: false }
        
end
