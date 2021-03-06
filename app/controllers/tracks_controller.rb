class TracksController < ApplicationController

include TracksHelper
  def new
    @track = Track.new
  end

  def index
  end

  def show
    @track = Track.find(params[:id])
  end

  def create
    track_origin
    if @track.save
      create_notification(@track_owner, @track)
      flash[:notice] = "Track uploaded"
    else
      flash[:notice] = "You need to enter track title before pressing upload"
    end
    redirect_to @track_owner
  end

  def destroy
    if params[:project_id]
      @track_owner = Project.find(params[:project_id])
    elsif params[:branch_id]
      @track_owner = Branch.find(params[:branch_id])
    end
    @track = @track_owner.tracks.find(params[:id]).destroy
    flash[:notice] = "Track deleted"
    redirect_to @track_owner
  end

  private
  def track_params
    params.require(:track).permit(:title, :text , :avatar, :user_id)
  end

  # def set_project
  #   @project = Project.find(params[:project_id])
  # end
end
