class InvitesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_club, only: [:index, :new, :create]
  before_action :set_invite, only: [:show, :destroy]
  before_action :verify_can_invite, only: [:index, :new, :create]
  before_action :verify_not_in_club, only: [:show]

  def index
    @invites = @club.invites
  end

  def new
    @invite = Invite.new(club: @club)
  end

  def create
    @invite = Invite.new(
      club: @club,
      user: current_user,
      hex: SecureRandom.hex,
    )

    if @invite.save
      redirect_to invites_path(@club)
    else
      render 'new'
    end
  end

  def show
  end

  private

  def set_club
    @club = Club.unscoped.friendly.find(params[:id])
  end

  def set_invite
    @invite = Invite.find_by(hex: params[:hex])
  end

  def verify_can_invite
    unless club_permissions(@club).can_invite?
      redirect_to root_path
    end
  end

  def verify_not_in_club
    redirect_to @invite.club if current_user.club?(@invite.club)
  end
end