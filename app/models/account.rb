class Account < ApplicationRecord
    has_many :transactions
    validates :name, :balance, presence: true

    def update_balance(transaction)
        binding.pry
        if transaction.kind == 'deposit'
            self.balance = self.balance + transaction.amount
            self.save
        else transaction.kind == 'withdrawal'
            if self.balance >= transaction.amount
            self.balance = self.balance - transaction.amount
            self.save
            else
                return "Balance too low."
            end
        end
    end

end


#adding a namespace will change the routes 
#http://localhost:3000/transitions -> http://localhost:3000/api/v1/transitions 


#EXAMPLE
#t = Transaction.create(amount:10, kind: 'deposit')
#a = Account.first
#a.update_balance(t)