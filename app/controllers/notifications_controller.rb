class NotificationsController < ApplicationController
  def link_through
    @notification = Notification.find(params[:id])
    @notification.update read: true
    @match = Match.find(@notification.match_id)
    redirect_to matches_path
  end
end
