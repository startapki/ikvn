class ParticipationsController < ApplicationController
  load_and_authorize_resource

  def create
    if @participation.save!
      redirect_to :back, notice: t('participation.created')
    else
      redirect_to :back, alert: t('participation.not_created')
    end
  end

  def destroy
    @participation.destroy

    redirect_to :back, notice: t('participation.destroyed')
  end

  private

  def participation_params
    params.require(:participation).permit(:user_id, :season_id, :role)
  end
end
