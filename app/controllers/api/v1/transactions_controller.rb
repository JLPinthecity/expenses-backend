class Api::V1::TransactionsController < ApplicationController

    before_action :set_account
    #we want to find transactions of a specific account

    def index
        if @account
            @transactions = @account.transactions
        else
            @transactions = Transaction.all
        end
        render json: @transactions
    end
    
    def show
        @transaction = @account.transactions.find_by(id: params[:id])
        render json: @transaction
    end

    def create
        @transaction = @account.transactions.new(transaction_params)
        if @account.update_balance(@transaction) != "Balance too low."
            @transaction.save 
            render json: @transaction
        else
            render json: {error: 'Balance too low.'}
        end
    end

    def destroy
        @account = Account.find(params[:id])
        @account.destroy
    end

    private 

    def set_account
        @account = Account.find(params[:account_id])
    end
    #we want to find the account from api/v1/accounts/1/transaction for example

    def transaction_params
        params.require(:transaction).permit(:amount, :amount_id, :kind, :date, :description)
    end

end
