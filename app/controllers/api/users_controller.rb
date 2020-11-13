class Api::UsersController < ApplicationController
    def index
        users = User.paginate(page: params[:page], per_page: 10)
        render json: {status: "success", messgae: "results are paginated", data: users}
    end

    def create
        user = User.new(user_params)
        if user.save 
            render json: {status: "success", message: "user added successfully", data: user}
        else
            render json: {status: "failed", message: "user creation failed", error: user.errors}
        end
    end

    def show 
        user = User.find_by(id: params[:id])
        if user.present? 
            render json: {status: "success",message: "user found", data: user}
        else
            render json: {status: "failed", message: "user not found"}
        end
        
    end

    def update
        user = User.find(params[:id])
        if user.update(user_params)
            render json: {status: "success", message: "user updated successfully", data: user}
        else
            render json: {status: "failed", message: "user was not updated", error: user.errors}
        end
    end

    def destroy
        user = User.find(params[:id])
        if user.delete
            render json: {status: "success", message: "user deleted successfully"}
        else
            render json: {status: "failed", message: "unable to delete user"}
        end
    end

    def typehead
        input = params[:input]
        users = User.where('first_name LIKE ?', "%#{input}%").or( User.where('last_name LIKE ?', "%#{input}%")).or( User.where('email_id LIKE ?', "%#{input}%"))
        render json: {status: "success", message: "search was successfull", data: users}
    end

    private 
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email_id)
    end
end
