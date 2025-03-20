class ProfilesController < ApplicationController
  before_action :set_user

  def edit
    # Renders the profile edit form (app/views/profiles/edit.html.erb)
  end

  def update
    if @user.update(user_params)
      redirect_to dashboard_path, notice: "Profile updated successfully."
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    terminate_session  # This method should log the user out.
    redirect_to root_path, notice: "Account deleted successfully."
  end

  def delete_account_confirmation
    render partial: "layouts/modal", locals: { modal_title: "Confirm Account Deletion" }
  end

  private

  def set_user
    @user = Current.user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email_address, :password, :password_confirmation)
  end
end
