class ClubMembershipsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_club
  before_action :generate_club_join_tip, only: :show

  def show
    @can_invite = club_permissions(@club).can_invite?
  end

  def new
    verify_joinable || begin
      redirect_to @club if current_user.club?(@club)
    end
  end

  def create
    verify_joinable_or_hex || begin
      unless current_user.club?(@club)
        current_user.clubs << @club
      end

      redirect_to @club
    end
  end

  private

  def set_club
    @club = Club.friendly.find(params[:id])
  end

  def verify_joinable
    unless club_permissions(@club).can_join?
      redirect_to root_path 
    end

    false
  end

  def verify_joinable_or_hex
    if club_permissions(@club).can_join?
      false
    elsif params[:hex]
      if (invite = @club.valid_join_hex?(params[:hex]))
        invite.increment!(:uses)
        false
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end
end