class Dispatcher

  attr_accessor :instructions

  def initialize robotIds
    @instructions = {}
    robotIds.each do |robotId|
      @instructions[robotId] = []
    end
  end

  def read_instructions robotId
    def parse_instruction line
      line = line.split(',')
      instruction = {
        'robotId' => line[0],
        'latitude' => line[1][1..line[1].length-2].to_f,
        'longitude' => line[2][1..line[2].length-2].to_f,
        'time' => line[3][12..line[3].length-3]
      }
    end
    f = File.open('./data/' + robotId + '.csv')
    f.each_line do |line|
      @instructions[robotId] << parse_instruction(line)
    end
    f.close
  end

  def next_jobs robotId
    jobs = @instructions[robotId].slice!(0,10)
    if (!jobs.length)
      return nil
    end
    return jobs
  end

end
