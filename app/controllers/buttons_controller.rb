class ButtonsController < ApplicationController
  # GET /buttons
  def index
    keys = $redis.keys("button:*")
    buttons = keys.map { |key| JSON.parse($redis.get(key)) }
    sorted_buttons = buttons.sort_by { |b| b["id"].to_i }
    render json: sorted_buttons, status: :ok
  end

  def show
    button_data = $redis.get("button:#{params[:id]}")
    if button_data
      render json: { button: JSON.parse(button_data) }, status: :ok
    else
      render json: { error: "Button not found" }, status: :not_found
    end
  end

  def update
    button_id = params[:id]
    status = params[:status]

    Rails.logger.debug "Received update request for button #{button_id} with status #{status}"

    if button_id && status
      button_key = "button:#{button_id}"
      existing_data = $redis.get(button_key)
      if existing_data
        # Обновляем только статус, сохраняя остальные поля
        button_data = JSON.parse(existing_data)
        button_data["status"] = status
      else
        # Если записи нет, можно попытаться создать её (либо вернуть ошибку)
        button = Button.find_by(id: button_id)
        if button
          button_data = {
            "id" => button.id,
            "status" => status,
            "element_id" => button.element_id,
            "label" => button.element.label
          }
        else
          render json: { error: "Button not found" }, status: :not_found and return
        end
      end

      Rails.logger.debug "Saving button data: #{button_data}"
      $redis.set(button_key, button_data.to_json)

      render json: { message: "Button updated successfully", button: button_data }, status: :ok
    else
      render json: { error: "Invalid parameters" }, status: :unprocessable_entity
    end
  rescue => e
    Rails.logger.error "Error while updating button: #{e.message}"
    render json: { error: "Internal Server Error" }, status: :internal_server_error
  end
end