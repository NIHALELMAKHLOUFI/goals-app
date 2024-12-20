class Goal < ApplicationRecord
    has_many :steps, dependent: :destroy
    validates :title, presence: true
 end
  