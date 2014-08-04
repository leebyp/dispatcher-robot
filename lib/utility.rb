require 'time'

class Utility

  @@R = 6371 # km

  def self.parse_station line
    line = line.split(',')
    station = {
      'name' => line[0],
      'latitude' => line[1].to_f,
      'longitude' => line[2][0, line[2].length-1].to_f
    }
  end

  def self.read_tube_data file_name
    stations = []
    f = File.open(file_name)
    f.each_line do |line|
      stations << self.parse_station(line)
    end
    f.close
    return stations
  end

  def self.radians num
    (Math::PI * num) / 180
  end

  def self.distance_converter lat1, lon1, lat2, lon2
    φ1 = self.radians(lat1)
    φ2 = self.radians(lat2)
    Δφ = self.radians(lat2-lat1)
    Δλ = self.radians(lon2-lon1)

    a = Math.sin(Δφ/2) * Math.sin(Δφ/2) +
            Math.cos(φ1) * Math.cos(φ2) *
            Math.sin(Δλ/2) * Math.sin(Δλ/2)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    d = @@R * c
  end

  def self.get_hour_minute time
    return (time[1]+time[3]+time[4]).to_i 
  end

  def self.speed time1, time2, distance
    t1 = Time.parse(time1)
    t2 = Time.parse(time2)
    return distance / (t2 - t1).abs
  end

end
