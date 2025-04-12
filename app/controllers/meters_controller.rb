class MetersController < ApplicationController
  before_action :force_json
  before_action :ensure_meters_cached

  def index
    meters = Rails.cache.read("meters") || {}
    render json: meters.values, status: :ok
  end

  def show
    meters = Rails.cache.read("meters") || {}
    meter = meters[params[:id].to_s]

    if meter
      render json: meter, status: :ok
    else
      render json: { error: "Meter not found" }, status: :not_found
    end
  end

  private

  def force_json
    request.format = :json
  end

  def ensure_meters_cached
    return if Rails.cache.read("meters")

    data = Meter.all.map do |m|
      {
        id: m.id,
        current_level: m.current_level,
        peak_level: m.peak_level,
        meter_type: m.meter_type,
        element_id: m.element_id
      }
    end
    Rails.cache.write("meters", data.index_by { |m| m[:id].to_s })
  end
end
