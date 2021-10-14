class Account < ApplicationRecord
    has_many :transactions
    validates :name, :balance, presence: true

    def update_balance(transaction)
        if transaction.kind == 'deposit'
            self.balance = self.balance + transaction.amount
            self.save
        elsif transaction.kind == 'withdrawal'
            if self.balance >= transaction.amount
            self.balance = self.balance - transaction.amount
            self.save
            else
                return "Balance too low."
            end
        end
    end

    def delete_transaction_from_total(transaction)
        if transition.kind == 'deposit'
            if self.balance >= transition.amount
            self.balance = self.balance - transaction.amount
            self.save
            else
                return "Balance too low" 
            end
        elsif transition.kind == 'withdrawal'
            self.balance = self.balance + transaction.amount
            self.save
        end
    end

end


#adding a namespace will change the routes 
#http://localhost:3000/transitions -> http://localhost:3000/api/v1/transitions 


#EXAMPLE
#t = Transaction.create(amount:10, kind: 'deposit')
#a = Account.first
#a.update_balance(t)