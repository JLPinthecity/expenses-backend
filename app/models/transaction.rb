class Transaction < ApplicationRecord
    belongs_to :account
    validates :amount, presence: true
    validates_inclusion_of :kind, :in => ['deposit', 'withdrawal']
end

#validates kind attribute is only either deposit or withdrawal