class FieldsController < ApplicationController
  before_action :check_current_field_owner, only: [:new, :create, :destroy]
  before_action :check_field_permission, only: [:destroy, :edit]
  before_action :set_field, only: [:show, :edit, :update, :destroy]

  def index
    @fields = Field.all
  end

  def show
    @hash = Gmaps4rails.build_markers(@field) do |field, marker|
      marker.lat field.latitude
      marker.lng field.longitude
    end
  end

  def new
    @field = current_field_owner.fields.build
  end

  def edit

  end

  def create
    @field = current_field_owner.fields.build(field_params)
    if @field.save
      flash[:success] = "Your field is created"
      redirect_to field_owner_fields_path
    else
      flash[:error] = @field.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def update
    if @field.update(field_params)
      flash[:success] = "Your field is updated"
      redirect_to field_owner_fields_path
    else
      flash[:error] = @field.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def destroy
    @field.destroy
    redirect_to field_owner_fields_path, flash: {notice: 'Field was successfully destroyed' }
  end

  private
    def set_field
      @field = Field.find(params[:id])
    end

    def field_params
      params.require(:field).permit(:name, :addr, :image_url, :venue_id)
    end
end
