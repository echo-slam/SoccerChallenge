class NotificationsController < ApplicationController
  def link_through
    @notification = Notification.find(params[:id])
    @notification.update read: true
    redirect_to @notification.return_path
  end

  def index
    @paths = []
    if current_player
      @notifications = current_player.notifications.where({read: false})  
    else
      @notifications = []
    end
    
    @notifications.each do |notify|
      @paths.push notify.return_path
    end
  end
end
