class Api::LocksController < ApplicationController
  before_action :authenticate_admin!

  def create
    @topic = Topic.find(params[:topic_id])
    @topic.update(lock_reason: params[:reason])
    render json: { locked: true }
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @topic.update(lock_reason: nil)
    render json: { locked: false }
  end
end