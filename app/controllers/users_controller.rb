class UsersController < ApplicationController

  helper_method :find_sender
  helper :all
  before_action :user_messages, :user_projects, :user_collaborations

  def show
  @user = User.find(params[:id])
  end

  def find_sender(message)
    User.find(message.sender)
  end

  private

  def user_messages
    @messages = Message.where(recipient: params[:id])
  end

  def user_projects
    @projects = Project.where(user_id: params[:id])
  end

  def user_collaborations
    @branches = Branch.where(user_id: params[:id])
  end

end
