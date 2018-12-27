class Question < ApplicationRecord
    has_many :category_questions
    has_many :categories, through: :category_questions
    validates :question, { presence: true, uniqueness: true }
    validates :answer, { presence: true }
end
