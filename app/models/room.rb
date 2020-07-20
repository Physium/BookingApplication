class Room < ApplicationRecord
    has_many :bookings, dependent: :destroy
    has_many :users, through: :bookings

    validates :name, presence: true, 
                        length: { minimum: 3, maximum: 25 },
                        uniqueness: { case_sensitive: false }
end
