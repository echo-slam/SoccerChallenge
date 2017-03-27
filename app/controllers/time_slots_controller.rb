class TimeSlotsController < ApplicationController

  def index
    @time_slots = TimeSlot.where(starts_at: params[:starts_at]..params[:ends_at])
  end

  def new
    @time_slot = TimeSlot.new
  end

  def edit
    
  end

  def create
    @time_slot = TimeSlot.new time_slot_params
    @time_slot.save
  end

  def update
    @time_slot.update time_slot_params
  end

  def destroy
    @time_slot.destroy
  end

  private
    def set_time_slot
      @time_slot = TimeSlot.find(params[:id])
    end

    def time_slot_params
      params.require(:time_slot).permit(:match_id, :field_id, :starts_at, :ends_at)
    end
end
