class FieldsController < ApplicationController
  before_action :check_current_field_owner, only: [:new, :create, :destroy]
  before_action :check_field_permission, only: [:destroy, :edit]

  def index
    @fields = current_field_owner.fields
  end

  def show
    @field = current_field_owner.fields.find(params[:id])
  end

  def new
    @venues = Venue.all
    @field_owner = set_field_owner
    @field = @field_owner.fields.build
  end

  def edit
    @venues = Venue.all
    @field_owner = set_field_owner
    @field = @field_owner.fields.find(params[:id])
  end

  def update
    @venues = Venue.all
    @field_owner = set_field_owner
    @field = @field_owner.fields.find(params[:id])

    if @field.update(field_params)
      flash[:success] = "Your field is updated"
      redirect_to root_path
    else
      flash[:error] = @field.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def create
    @venues = Venue.all
    @field_owner = set_field_owner
    @field = @field_owner.fields.build(field_params)
    if @field.save
      flash[:success] = "Your field is created"
      redirect_to root_path
    else
      flash[:error] = @field.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def destroy
    @field = current_field_owner.fields.find(params[:id])
    @field.destroy
  end

  private
    def set_field_owner
      current_field_owner
    end

    def field_params
      params.require(:field).permit(:name, :addr, :image_url, :venue_id)
    end
end
