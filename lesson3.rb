class Station #Станция
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train) # Принимаем поезда
    trains << train
  end

  def trains_type(type) # Список поездов на станции по типу
    trains.select { |train| train.type == type}
  end

  def send_train(train) # Отправка поезда
    trains.delete(train)
  end
end

class Route #Маршрут
  attr_reader :routes, :stations

  def initialize(station_first, station_last)
    @routes = [station_first, station_last]
  end

  def add_station(station) #Добавление станции
    if routes.include?(station)
      puts "Такая станция уже есть"
    else
      routes.insert(-1, station)
    end
  end

  def delete_station(station) # Удаление станции
    if !routes.include?(station)
      puts "Такой станции нет!"
    else
      routes.delete(station)
    end
  end
end

class Train #Поезд
  attr_accessor :number, :type, :wagons_count, :speed, :route, :trains, :current_station_index

  @trains = {}

  def initialize(number, type, wagons_count)
    @number = number
    @type = type
    @wagons_count = wagons_count
    @speed = 0
  end

  def speed_up(speed) # Увеличение скорости
    if speed <= 0
      puts "Скорость не может быть меньше 0"
    else
      @speed += speed
    end
  end

  def speed_down # Уменьшение скорости
    if speed < 0 || (self.speed - speed) < 0
      puts "Скорость не может быть меньше 0"
    else
      @speed -= speed
      puts "Поезд остановился" if self.speed == 0
    end
  end

  def stop # Остановка
    self.speed = 0
  end

  def quantity_wagons_count # Колличество вагонов
    puts "Количество вагонов: #{self.wagons_count}"
  end

  def add_vagons_count # Добавление вагонов
    if self.speed == 0
      self.wagons_count += 1
    else
      puts "Нельзя добавить вагон на ходу!"
    end
  end

  def delete_vagons_count #Уменьшение вагонов
    if self.speed == 0
      self.wagons_count -= 1
    else
      puts "Нельзя убрать вагон на ходу!"
    end
  end

  def assign_route(route)
    @route = route
    @current_station_index = 0
  end

  def move_forward # Движение вперед
    @current_station_index += 1 if current_station_index < route.stations.size
  end

  def move_backward # Движение назад
    @current_station_index -= 1 if current_station_index > 0
  end

    def current_station # Текущая станция
      route[current_station_index]
    end

    def next_station # Следующая станция
      route[current_station_index + 1]
    end

    def previous_station # Предыдущая станция
      route[current_station_index - 1]
      end
end
