class Api::V1::TransactionsController < ApplicationController
    skip_forgery_protection

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
            render json: @account
        else
            render json: {error: 'Balance too low.'}
        end
    end

    def destroy
        @transaction = Transaction.find(params["id"])
        @account = Account.find(@transaction.account_id)
        if @account.delete_transaction_from_total(@transaction)
            @transaction.destroy
            render json: @account
        else
            render json: {error: 'Balance too low'}
        end
    end

    def update
        binding.pry
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
