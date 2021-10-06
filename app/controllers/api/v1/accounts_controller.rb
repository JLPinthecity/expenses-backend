class Api::V1::AccountsController < ApplicationController
    skip_forgery_protection

    def index
        @accounts = Account.all
        render json: @accounts
    end

    def create
        binding.pry
        @account = Account.create(account_params)
        if @account.save 
            render json: @account
        else
            render json: {error: 'Error creating account.'}
        end
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

    def account_params
        params.require(:account).permit(:name, :balance)
    end

end
