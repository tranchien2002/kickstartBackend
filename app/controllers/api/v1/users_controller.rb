class Api::V1::UsersController < ApplicationController
	before_action :load_user, only: %i(show update destroy)
	before_action :correct_user?, only: %i(update destroy)
	def show
		render json: {
			data: @user.as_json(only: [:id, :email])
		}
	end

	def create
		byebug
		@user = User.new user_params
		if @user.save
			render json: {
				status: true,
			}
		else
			render json: {
				status: false,
        message: @user.errors.full_messages
			}
		end
	end

	def update
    if @user.update_attributes params_user
      render json: {
        status: true
      }
    else
      render json: {
        status: false,
        message: @user.errors.full_messages
      }
    end
	end
	
	def destroy
		if @user.destroy
			render json: {
				status: true
			}
		else
			render json: {
				status: false,
				message: @user.errors.full_messages
			}
		end
	end
	private 
	def user_params
		params.require(:user).permit :email, :password, :password_confirmation
	end

	def load_user
		@user = User.find_by id: params[:id]
		unless @user
			render json: {
				status: false,
				message: Settings.not_found
			}
		end
	end

	def correct_user?
		unless current_user?(@user)
			render json: {
				status: false,
				message: Settings.perpermission_denied
			}
		end
	end
end
