class Station #Станция

  attr_reader :name, :trains

  @stations = {}

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_station(station) # Добавляем станцию в хеш
    @stations << station
  end

  def station_all # Выводим все станции
    @stations.each {|station| puts "#{station.inspect}"}
  end

  def add_train(train) # Принимаем поезда
    @trains << train
  end

  def list_train # Список всех поездов на станции
    @trains.each { |train|  puts "Станция: #{self.name}, Поезд: #{train}"}
  end

  def list_train_type(type) # Список поездов на станции по типу
    @trains.each { |train|  puts "Станция: #{self.name}, Поезд: #{train}, Тип: #{type}"if train.type == type}
  end

  def send_train(train) # Отправка поезда
    puts "Поезд отправляется!"
    @trains.delete(train)
  end

end

class Route #Маршрут

  attr_reader :routes, :stations

  @routes = {}

  def initialize(station_first, station_last)
    @routes = [station_first, station_last]
  end

  def add_station(station) #Добавление станции
    if @stations.include?(station)
      puts "Такая станция уже есть"
    else
      @stations.insert(-1, station)
    end
  end

  def del_station(station) # Удаление станции
    if !@stations.include?(station)
      puts "Такой станции нет!"
    else
      @stations.delete(station)
    end
  end

  def list_route # Список всех станций на маршруте
    @routes.each {|route|puts "Маршрут: #{route.inspect}"}
  end

end

class Train #Поезд

  attr_accessor :num, :type, :vag, :speed, :route, :station_id, :trains

  @trains = {}

  def initialize(num, type, vag)
    @num = num
    @type = type
    @vag = vag
    @speed = 0
  end

  def train_add(train) # Добавляем поезда в хеш
    @trains << train
  end

  def train_all
    @trains.each { |train| puts "#{train}"}
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

  def current_speed # Текущая скорость
    puts "Текущая скорость: #{@speed}"
  end

  def stop # Остановка
    self.speed = 0
  end

  def quantity_van # Колличество вагонов
    puts "Количество вагонов: #{self.vag}"
  end

  def add_van # Добавление вагонов
    if self.speed == 0
      self.vag += 1
    else
      puts "Нельзя добавить вагон на ходу!"
    end
  end

  def del_van #Уменьшение вагонов
    if self.speed == 0
      self.vag -= 1
    else
      puts "Нельзя убрать вагон на ходу!"
    end
  end

  def move_forward # Движение вперед
    if station_id.between?(0,route.stations.count-1)
      puts "Станции нет в маршруте"
    elsif station_id >= route.stations.count-1
      puts "Конечная"
    else
      puts "Текущая станция: #{route.stations[station_id]}"
      self.station_id += 1
      puts "Поезд прибыл на станцию: #{route.stations[station_id]}"
    end
  end

  def move_back # Движение назад
    if station_id.between?(0,route.stations.count-1) && station_id == 0
      puts "Начальная"
    else
      puts "Текущая станция: #{route.stations[station_id]}"
      self.station_id -= 1
      puts "Поезд прибыл на станцию: #{route.stations[station_id]}"
    end
  end

    def current_station # Текущая станция
      puts "Текущая станция: #{route.stations[station_id]}"
    end

    def next_station # Следующая станция
      if route.stations.count-station_id < 0
        puts "Станции нет в маршруте"
      elsif route.stations.count-1 == station_id
        puts "Конечная"
      else
        puts "Следующая станция: #{route.stations[station_id+1]}"
      end
    end

    def pred_station # Предыдущая станция
      if route.stations.count-station_id < 0
        puts "Станции нет в маршруте"
      elsif station_id.zero?
        puts "Начальная"
      else
        puts "Предыдущая станция: #{route.stations[station_id-1]}"
      end
      end
  end
