class NotificationsController < ApplicationController
  def link_through
    @notification = Notification.find(params[:id])
    @notification.update read: true
    redirect_to @notification.return_path
  end

  def index
    @paths = []
    @notifications = current_player.notifications.where({read: false})
    @notifications.each do |notify|
      @paths.push notify.return_path
    end

    respond_to do |format|
      format.html
      format.json {render json: { notifications: @notifications,
                                  paths: @paths }}
    end
  end
end
