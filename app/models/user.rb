class User < ActiveRecord::Base
    require 'csv'
    CSV_FILE_NAME = Rails.root.join('vendor', 'zip_code_database.csv')
    #require 'UsersHelper'
    
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

    validate :validate_zip

    def validate_zip
      logger.debug "in validate_zip"
      found = false
      
      File.open(CSV_FILE_NAME) do |file|
        logger.debug "in file_open"
        
        CSV.parse(file.read) do |row|
        logger.debug "in parse"
          if row[0] == self.zip
            found = true
            if row[5] == self.state
              return true
            end
          end
        end
      end
      
      unless found
        # zip was not in file
        errors.add(:field, 'Invalid Zip code')
      else
        # zip and state don't match
        errors.add(:base, 'Zip and State do not match')
      end
    end
end
