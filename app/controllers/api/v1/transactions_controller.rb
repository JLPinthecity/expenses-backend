class Api::V1::TransactionsController < ApplicationController

    before_action :set_account
    #we want to find transactions of a specific account

    def index
        
        render json: @accounts
    end

    def create
        @account = Account.create(account_params)
        if @account.save 
            render json: @account
        else
            render json: {error: 'Error creating account.'}
    end
    
    def show
        @account = Account.find(params[:id])
        render json: @account
    end

    def destroy
        @account = Account.find(params[:id])
        @account.destroy
    end

    private 

    def set_account
        @account = Account.find(params[:account_id])
    end
    #we want to find the account from api/v1/accounts/1 for example

    def transaction_params
        params.require(:transaction).permit(:amount, :amount_id, :kind, :date, :description)
    end

end
