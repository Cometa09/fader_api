puts "Очищаем базу данных..."
PresetSetting.destroy_all
Preset.destroy_all
ConfigurationElement.destroy_all
Configuration.destroy_all
Button.destroy_all
Fader.destroy_all
Element.destroy_all
EQSlider.destroy_all
Knob.destroy_all
Meter.destroy_all
Display.destroy_all
ChannelGroupMapping.destroy_all
Channel.destroy_all
Group.destroy_all
Output.destroy_all
User.destroy_all

puts "Создаем пользователей: Admin и User"
admin = User.create!(username: "admin", password: "secret")
user  = User.create!(username: "user",  password: "secret")

puts "Создаем конфигурации пульта для каждого пользователя"
admin_config = Configuration.create!(user: admin, name: "Пульт Admin", description: "Конфигурация пульта для администратора")
user_config  = Configuration.create!(user: user,  name: "Пульт User",  description: "Конфигурация пульта для пользователя")

puts "Создаем 8 фейдеров с кнопками под ними (start, stop)"
8.times do |i|
  # Фейдер как элемент
  fader_element = Element.create!(
    element_type: :fader,
    x_position: 100 * i,
    y_position: 100,
    width: 50,
    height: 300,
    label: "Fader #{i+1}",
    control_function: :volume,
    target_type: "global"  # для общего назначения
  )
puts"Записываем значение фейдера"
  Fader.create!(element: fader_element, default_value: 0, value: 0, min_value: 0, max_value: 100)

  # Под фейдером создаем 2 кнопки: start и stop
  ["start", "stop"].each_with_index do |action, index|
    button_element = Element.create!(
      element_type: :button,
      x_position: 100 * i,
      y_position: 420 + index * 30,
      width: 30,
      height: 30,
      label: "Fader #{i+1} #{action.capitalize}",
      control_function: :send,  # выбранна функция send для примера
      target_type: "global"
    )
    Button.create!(element: button_element, image_path: "#{action}.png", status: "inactive")
  end
end

puts "Создаем каналы входов"
# 3 микрофонных входа
3.times do |i|
  Channel.create!(label: "Mic #{i+1}")
end

# 5 линейных входов
5.times do |i|
  Channel.create!(label: "Line #{i+1}")
end

puts "Для каждого канала создаем трехполосный эквалайзер"
Channel.all.each do |channel|
  # Создаем элемент эквалайзера для данного канала
  eq_element = Element.create!(
    element_type: :eq_slider,
    x_position: 50,
    y_position: 600, # произвольная позиция
    width: 200,
    height: 50,
    label: "EQ for #{channel.label}",
    control_function: :eq,
    target_type: "channel",
    target_id: channel.id
  )
  # Создаем 3 слайдера для диапазонов low, mid, high
  EQSlider.create!(element: eq_element, frequency_band: :low, default_value: 0, value: 0, min_value: -10, max_value: 10)
  EQSlider.create!(element: eq_element, frequency_band: :mid, default_value: 0, value: 0, min_value: -10, max_value: 10)
  EQSlider.create!(element: eq_element, frequency_band: :high, default_value: 0, value: 0, min_value: -10, max_value: 10)
end

puts "Создаем выходы"
# 3 выхода на наушники
3.times do |i|
  Output.create!(label: "Headphones #{i+1}")
end

# Стерео выход для контрольных акустических мониторов
Output.create!(label: "Control Monitors Stereo")
# Стерео main выход для колонок
Output.create!(label: "Main Speakers Stereo")

puts "Создаем 2 тестовых пресета для каждого пользователя."
# Каждый пресет сохраняет настройки первых 3 фейдеров из таблицы elements.
[admin, user].each do |usr|
  2.times do |p|
    preset = Preset.create!(
      user: usr,
      name: "Preset #{p+1} for #{usr.username}",
      description: "Тестовый пресет #{p+1} для #{usr.username}"
    )
    # Для демонстрации, сохраняем значение первых 3 фейдеров.
    Element.where(element_type: Element.element_types[:fader]).limit(3).each do |elem|
      # В данном примере значение пресета — значение фейдера + небольшое смещение в зависимости от номера пресета.
      new_value = elem.faders.first.value + p * 10
      PresetSetting.create!(preset: preset, element: elem, value: new_value.to_s)
    end
  end
end

puts "Данные успешно загружены!"

puts "Инициализируем Redis значениями фейдеров и кнопок..."

Fader.find_each do |f|
  $redis.set("fader:#{f.element_id}", {
    id: f.id,
    value: f.value,
    element_id: f.element_id,
    label: f.element.label
  }.to_json)
end

Button.find_each do |b|
  $redis.set("button:#{b.element_id}", {
    id: b.id,
    status: b.status == "active" ? "ON" : "OFF",
    element_id: b.element_id,
    label: b.element.label
  }.to_json)
end

puts "Redis успешно инициализирован!"