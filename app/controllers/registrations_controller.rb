class RegistrationsController < ApplicationController
    # Allow unauthenticated access since new users won't have a session yet
    allow_unauthenticated_access

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        start_new_session_for(@user)
        redirect_to dashboard_path, notice: "You have signed up successfully."
      else
        flash[:alert] = @user.errors.full_messages.join(", ")
        render :new, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email_address, :password, :password_confirmation)
    end
end
