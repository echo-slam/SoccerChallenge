class FieldOwnersController < ApplicationController
  def new
    @field_owner = FieldOwner.new
  end

  def create
    @field_owner = FieldOwner.new field_owner_params
    if @field_owner.save
      FieldOwnerMailer.welcome_field_owner(@field_owner).deliver_later

      flash[:success] = 'Register successfully'
      session[:field_owner_id] = @field_owner.id
      
      redirect_to root_path
    else
      flash[:error] = @field_owner.errors.full_messages.to_sentence
      render 'new'
    end
  end

  private
    def field_owner_params
      params.require(:field_owner).permit(:full_name, :email, :password, :image_url)
    end
end
