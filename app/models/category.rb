class Category < ApplicationRecord
    has_many :category_questions
    has_many :questions, through: :category_questions
    validates :name, { presence: true, uniqueness: true }
end
