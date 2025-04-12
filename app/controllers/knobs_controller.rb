class KnobsController < ApplicationController
  before_action :force_json
  before_action :ensure_knobs_cached

  def index
    knobs = Rails.cache.read("knobs") || {}
    render json: knobs.values, status: :ok
  end

  def show
    knobs = Rails.cache.read("knobs") || {}
    knob = knobs[params[:id].to_s]

    if knob
      render json: knob, status: :ok
    else
      render json: { error: "Knob not found" }, status: :not_found
    end
  end

  def update
    knobs = Rails.cache.read("knobs") || {}
    id = params[:id].to_s
    new_value = params[:value].to_i

    if knobs[id]
      knobs[id]["value"] = new_value
      Rails.cache.write("knobs", knobs)
      render json: knobs[id], status: :ok
    else
      render json: { error: "Invalid knob ID" }, status: :unprocessable_entity
    end
  end

  private

  def force_json
    request.format = :json
  end

  def ensure_knobs_cached
    return if Rails.cache.read("knobs")

    knobs_data = Knob.all.map do |knob|
      {
        id: knob.id,
        value: knob.value,
        element_id: knob.element_id
      }
    end
    Rails.cache.write("knobs", knobs_data.index_by { |k| k[:id].to_s })
  end
end
