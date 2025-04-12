class EqSlidersController < ApplicationController
  before_action :force_json
  before_action :ensure_eq_cached

  def index
    eq = Rails.cache.read("eq_sliders") || {}
    render json: eq.values, status: :ok
  end

  def show
    eq = Rails.cache.read("eq_sliders") || {}
    slider = eq[params[:id].to_s]

    if slider
      render json: slider, status: :ok
    else
      render json: { error: "EQ Slider not found" }, status: :not_found
    end
  end

  def update
    eq = Rails.cache.read("eq_sliders") || {}
    id = params[:id].to_s
    new_value = params[:value].to_i

    if eq[id]
      eq[id]["value"] = new_value
      Rails.cache.write("eq_sliders", eq)
      render json: eq[id], status: :ok
    else
      render json: { error: "Invalid EQ slider ID" }, status: :unprocessable_entity
    end
  end

  private

  def force_json
    request.format = :json
  end

  def ensure_eq_cached
    return if Rails.cache.read("eq_sliders")

    eq_data = EqSlider.all.map do |slider|
      {
        id: slider.id,
        value: slider.value,
        frequency_band: slider.frequency_band,
        element_id: slider.element_id
      }
    end
    Rails.cache.write("eq_sliders", eq_data.index_by { |s| s[:id].to_s })
  end
end
