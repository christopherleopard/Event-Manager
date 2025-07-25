class EmergencyAlertsController < ApplicationController
  before_action :set_emergency_alert, only: %i[ show edit update destroy ]

  def index
    @emergency_alerts = EmergencyAlert.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @emergency_alert = EmergencyAlert.new
  end

  def edit
  end

  def create
    @emergency_alert = EmergencyAlert.new(emergency_alert_params)

    if @emergency_alert.save
      redirect_to emergency_alerts_path, notice: "Emergency alert was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @emergency_alert.update(emergency_alert_params)
      redirect_to emergency_alerts_path, notice: "Emergency alert was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @emergency_alert.destroy
    redirect_to emergency_alerts_path, notice: "Emergency alert was successfully deleted."
  end

  private

    def set_emergency_alert
      @emergency_alert = EmergencyAlert.find(params[:id])
    end

    def emergency_alert_params
      params.require(:emergency_alert).permit(:name, :message, :enabled)
    end
end
