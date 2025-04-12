class FadersController < ApplicationController
  before_action :force_json

  def index
    keys = $redis.keys("fader:*")
    faders = keys.map { |key| JSON.parse($redis.get(key)) }

    sorted_faders = faders.sort_by { |f| f["id"].to_i }

    render json: sorted_faders, status: :ok
  end

  def show
    data = $redis.get("fader:#{params[:id]}")
    if data
      render json: JSON.parse(data), status: :ok
    else
      render json: { error: "Fader not found" }, status: :not_found
    end
  end

  def update
    id = params[:id]
    value = params[:value].to_i

    key = "fader:#{id}"
    data = $redis.get(key)
    if data
      fader = JSON.parse(data)
      fader["value"] = value
      $redis.set(key, fader.to_json)
      render json: fader, status: :ok
    else
      render json: { error: "Fader not found" }, status: :not_found
    end
  end

  private

  def force_json
    request.format = :json
  end
end
