class User < ApplicationRecord
    validates :email_id, uniqueness: true
    
end
