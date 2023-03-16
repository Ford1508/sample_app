class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    before_save :downcase_email
    
    validates :name, presence: true, length: {maximum: 50}
    validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: true
    
    has_secure_password
    
    # before_save :test_callback_before_save
    # around_save :test_callback_around_save
    # after_save :test_callback_after_save

    # def test_callback_before_save
    #     puts "before save"
    # end

    # def test_callback_around_save
    #     puts "in around save"
    #     yield # User saved
    #     puts "out around save"
    # end

    # def test_callback_after_save
    #     # puts "after save"
    #     raise "raise exception"
    # end
    
    # Returns the hash digest of the given string.
    def User.digest string
        cost = if ActiveModel::SecurePassword.min_cost
                    BCrypt::Engine::MIN_COST
               else
                    BCrypt::Engine.cost
               end
        BCrypt::Password.create string, cost: cost
    end

    private
    
    def downcase_email
        self.email.downcase!
    end


end
