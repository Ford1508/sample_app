class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    before_save :downcase_email
    
    validates :name, presence: true, length: {maximum: 50}
    validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: true
    
    has_secure_password
    attr_accessor :remember_token
    
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
    
    
    class << self
        # Returns the hash digest of the given string.
        def digest string
            cost = if ActiveModel::SecurePassword.min_cost
                        BCrypt::Engine::MIN_COST
                   else
                        BCrypt::Engine.cost
                   end
            BCrypt::Password.create string, cost: cost
        end

        def new_token
            SecureRandom.urlsafe_base64
        end
    end

    def remember
        self.remember_token = User.new_token
        update_column :remember_digest, User.digest(remember_token)
    end

    def authenticate? remember_token
        BCrypt::Password.new(remember_digest).is_password? remember_token
    end

    def forget
        update_column :remember_digest, nil
    end

    private

    def downcase_email
        self.email.downcase!
    end


end
