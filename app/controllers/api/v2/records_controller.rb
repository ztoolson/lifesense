class Api::V2::RecordsController < ApplicationController
  respond_to :json
  before_action :authenticate
  skip_before_filter :verify_authenticity_token

  def show
    respond_with record
  end

  def create
		# TODO send error messages
    transmitter = @current_user.transmitters.find_by(transmitter_token: record_params["transmitter_token"]) if @current_user 

    sensor = @current_user.sensors.find_by(transmitter: transmitter, pin_number: record_params["pin_number"]) if transmitter
    @record = sensor.records.build(time_stamp: DateTime.now.to_i * 1000, value: record_params["value"])
    @record.save

    respond_with :api, status: :created, json: @record
  end

	def update
		respond_with record.update(transmitter_params)
	end

  def destroy
    respond_with record.destroy
  end

  private 

  def record
    Record.find(params[:id])
  end

  def record_params
    # make additional required params
    params.require(:record).require(:transmitter_token)
    params.require(:record).require(:pin_number)
    # setup for hash structure
    params.require(:record).permit(:value, :time_stamp, :transmitter_token, :pin_number)
  end

end