class FieldOwnersController < ApplicationController
  before_action :set_team_owner, only: [:show, :edit, :update]

  def index
    @field_owners = FieldOwner.all
  end

  def show
    @fields = @field_owner.fields
    @matches = Match.where(field_id: @field_owner.field_ids)
  end

  def new
    @field_owner = FieldOwner.new
  end

  def edit
    
  end

  def create
    @field_owner = FieldOwner.new field_owner_params
    if @field_owner.save
      FieldOwnerMailer.welcome_field_owner(@field_owner).deliver_later

      flash[:success] = 'Register successfully'
      session[:field_owner_id] = @field_owner.id
      
      redirect_to field_owner_path(@field_owner)
    else
      flash[:error] = @field_owner.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def update
    if @field_owner.update(field_owner_params)
      redirect_to field_owner_path(@field_owner), flash: { success: 'Field Owner profile was successfully updated' }
    else
      flash[:error] = @field_owner.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  private
    def set_team_owner
      @field_owner = current_field_owner
    end

    def field_owner_params
      params.require(:field_owner).permit(:full_name, :email, :password, :image_url)
    end
end
