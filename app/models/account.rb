class Account < ApplicationRecord

    namespace :api do 
        namespace :v1 do
            has_many :transactions
            validates :name, :balance, presence: true
        end
    end
end


#adding a namespace will change the routes 
#http://localhost:3000/transitions -> http://localhost:3000/api/v1/transitions 