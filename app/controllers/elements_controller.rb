# app/controllers/elements_controller.rb
class ElementsController < ApplicationController
  def index
    elements = Element.all.map do |element|
      case element.element_type
      when "fader"
        fader_data = fetch_fader_data(element.id)
        element.attributes.merge(fader: fader_data)
      when "button"
        button_data = fetch_button_data(element.id)
        element.attributes.merge(button: button_data)
      else
        element.attributes
      end
    end

    render json: elements
  end

  def show
    @element = Element.find_by(id: params[:id])

    if @element
      # Если элемент найден, пытаемся найти фейдер, связанный с этим элементом
      if @element.element_type == "fader"
      fader = Fader.find_by(element_id: @element.id)

      if fader
        render json: {
          fader: {
            id: fader.id,
            value: fader.value,
            element_id: fader.element_id
          }
        }, status: :ok
      else
        render json: { error: "Fader not found for this element" }, status: :not_found
      end
       # Проверяем, если элемент является кнопкой
      elsif @element.element_type == "button"
        button = Button.find_by(element_id: @element.id)

        if button
          render json: {
            button: {
              id: button.id,
              status: button.status,
              element_id: button.element_id
            }
          }, status: :ok
        else
          render json: { error: "Button not found for this element" }, status: :not_found
        end
      else
        render json: { error: "Element type not supported" }, status: :unprocessable_entity
      end

    else
      render json: { error: "Element not found" }, status: :not_found
    end
  end
  
  def update_fader
    fader = Fader.find_by(id: params[:id])
    return render json: { error: "Fader not found" }, status: :not_found unless fader

    value = params[:value].to_i
    key = "fader:#{fader.element_id}"
    data = fetch_fader_data(fader.element_id)
    data["value"] = value
    $redis.set(key, data.to_json)

    render json: { success: true, fader: data }
  end

  def update_button
    button = Button.find_by(id: params[:id])
    return render json: { error: "Button not found" }, status: :not_found unless button

    status = params[:status].to_s.upcase
    key = "button:#{button.element_id}"
    data = fetch_button_data(button.element_id)
    data["status"] = status
    $redis.set(key, data.to_json)

    render json: { success: true, button: data }
  end

  private

  def fetch_fader_data(element_id)
    key = "fader:#{element_id}"
    cached = $redis.get(key)
    return JSON.parse(cached) if cached

    fader = Fader.find_by(element_id: element_id)
    return {} unless fader

    data = {
      id: fader.id,
      value: fader.value,
      element_id: fader.element_id,
      label: fader.element.label
    }
    $redis.set(key, data.to_json)
    data
  end

  def fetch_button_data(element_id)
    key = "button:#{element_id}"
    cached = $redis.get(key)
    return JSON.parse(cached) if cached

    button = Button.find_by(element_id: element_id)
    return {} unless button

    data = {
      id: button.id,
      status: button.status,
      element_id: button.element_id,
      label: button.element.label
    }
    $redis.set(key, data.to_json)
    data
  end
end
