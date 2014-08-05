require './lib/utility.rb'
require './lib/dispatcher.rb'
require './lib/robot.rb'

def send_jobs dispatcher, robot, stations
  puts 'Dispatcher sending jobs to robot' + robot.id + ' ...'
  jobs = dispatcher.next_jobs(robot.id)
  if (jobs)
    puts 'Robot' + robot.id + ' moving and detecting stations...'
    jobs_results = robot.perform_jobs(jobs, stations)
  end
  if (!robot.shutdown())
    send_jobs(dispatcher, robot, stations)
  else
    puts 'Robot' + robot.id + ' shutting down...'
  end
end

dispatcher = Dispatcher.new(['5937','6043'])
robot5937 = Robot.new('5937')
robot6043 = Robot.new('6043')
stations = []

t1 = Thread.new {
  stations.concat(Utility.read_tube_data('./data/tube.csv'))
}
t2 = Thread.new {
  dispatcher.read_instructions('5937')
}
t3 = Thread.new {
  dispatcher.read_instructions('6043')
}
t1.join
t2.join
t3.join

t1 = Thread.new {
  send_jobs(dispatcher, robot5937, stations)
}
t2 = Thread.new {
  send_jobs(dispatcher, robot6043, stations)
}
t1.join
t2.join
