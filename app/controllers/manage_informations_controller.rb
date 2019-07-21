class ManageInformationsController < ApplicationController
  include Common
  before_action :permit_admin

  def index
    @informations = Information.all
    @users = User.all
  end

  def new
    @information = Information.new

    users = User.all

    @users_name_array = ["everyone"]
    users.each do |user|
      @users_name_array << "@" + user.user_id
    end
  end

  def create

    if information_params[:user_id] == "everyone"
      User.all.each do |user|
        @information = user.informations.build(information_params)
        @information.save
      end
      redirect_to manage_informations_url
    else
      user = User.find_by(user_id: information_params[:user_id].delete("@"))
      @information = user.informations.build(information_params)
      if @information.save
        redirect_to manage_informations_url
      else
        render :new
      end
    end
  end

  def destroy
    @information = Information.find_by(id:params[:id])
    @information.destroy
    redirect_to manage_informations_url
  end

  private

  def information_params
    params.require(:information).permit(
                                  :content,
                                  :user_id
                                )
  end

end
