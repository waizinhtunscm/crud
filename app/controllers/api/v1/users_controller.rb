class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
    # GET /users
    def index
        @users = User.all
        render json: @users
    end
    # GET /users/:id
    def show
      @user = User.find(params[:id])
      render json: @user
    end
    
    # POST /users
    def create
      @user = User.new(user_params)
      if @user.save
        render json: @user    
      else
        render  error: {error: 'Unable to create user.'}, status: 400
      end
    end
    # PUT /users/:id
    def update
      @user = User.find(params[:id])
      if @user
        @user.update(user_params)
        render json: {message: 'User successfully updated.'}, status: 200
      else
        render  json: {error: 'Unable to update user.'}, status: 400
      end
    end
    # DELETE users/:id
    def destory
      @user = User.find(params[:id])
      if @user
        @user.destory
        render json: {message: 'User successfully deleted.'}, status: 200
      else
        render json: {error: 'Unable to delete user.'}, status: 400
      end
    end

    def healthcheck
      render plain: "ok par naw pyan run tar par"
    end
    
    private
    def user_params
      params.require(:user).permit(:username,:password)
    end
    
end
