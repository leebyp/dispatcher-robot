require './lib/utility'

class Robot

  attr_accessor :id, :speed, :latitude, :longitude, :time

  def initialize robotId
    @id = robotId
  end

  def scan stations, nextJob
    job_result = []
    condition = ['HEAVY', 'LIGHT', 'MODERATE']
    stations.each do |station|
      station_distance = Utility.distance_converter(@latitude, @longitude, station['latitude'], station['longitude'])
      if (station_distance < 0.35)
        traffic_info = 'Tube station found! id: ' + @id.to_s + ', time: ' + @time.to_s + ', ' +
          'speed: ' + @speed.to_s + ', condition: ' + condition[rand(3)]
        job_result.push(traffic_info)
        puts traffic_info
      end
    end
    return job_result
  end

  def shutdown
    hour = Utility.get_hour_minute(@time)
    if (hour >= 810)
      return true
    end
    return false
  end

  def perform_jobs jobs, stations
    jobs_results = []
    for i in 0...jobs.length-1
      @time = jobs[i]['time']
      @latitude = jobs[i]['latitude']
      @longitude = jobs[i]['longitude']
      if (shutdown())
        return
      end
      distance = Utility.distance_converter(@latitude, @longitude, jobs[i+1]['latitude'], jobs[i+1]['longitude'])
      @speed = Utility.speed(@time, jobs[i+1]['time'], distance) * 1000
      jobs_results.concat(scan(stations, jobs[i+1]))
    end
    return jobs_results
  end


end
