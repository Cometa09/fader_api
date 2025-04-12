class DisplaysController < ApplicationController
  before_action :force_json
  before_action :ensure_displays_cached

  def index
    displays = Rails.cache.read("displays") || {}
    render json: displays.values, status: :ok
  end

  def show
    displays = Rails.cache.read("displays") || {}
    display = displays[params[:id].to_s]

    if display
      render json: display, status: :ok
    else
      render json: { error: "Display not found" }, status: :not_found
    end
  end

  def update
    displays = Rails.cache.read("displays") || {}
    id = params[:id].to_s
    new_value = params[:value].to_i

    if displays[id]
      displays[id]["value"] = new_value
      Rails.cache.write("displays", displays)
      render json: displays[id], status: :ok
    else
      render json: { error: "Invalid display ID" }, status: :unprocessable_entity
    end
  end

  private

  def force_json
    request.format = :json
  end

  def ensure_displays_cached
    return if Rails.cache.read("displays")

    data = Display.all.map do |d|
      {
        id: d.id,
        value: d.value,
        display_type: d.display_type,
        element_id: d.element_id
      }
    end
    Rails.cache.write("displays", data.index_by { |d| d[:id].to_s })
  end
end
