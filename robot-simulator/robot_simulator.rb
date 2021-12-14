class Simulator
  OPCODES = {
    "A" => :advance,
    "R" => :turn_right,
    "L" => :turn_left
  }

  def instructions(list)
    list.each_char.map {|x| OPCODES[x] }
  end

  def place(robot, x:, y:, direction:)
    robot.at(x,y)
    robot.orient(direction)
  end

  def evaluate(robot, opcode_list)
    instructions(opcode_list)
      .each {|x| robot.send(x) }
  end
end

class Robot
  DIRECTION_VECTORS = {
    north: [0,1], east: [1,0], south: [0,-1], west: [-1,0]
  }.freeze
  DIRECTIONS = DIRECTION_VECTORS.keys.freeze

  attr_reader :bearing

  def orient(dir)
    raise ArgumentError unless DIRECTIONS.include?(dir)
    @bearing = dir
  end

  def turn_right
    turn(1)
  end

  def turn_left
    turn(-1)
  end

  def at(x, y)
    @x, @y = x, y
  end

  def coordinates
    [@x, @y]
  end

  def advance
    vector = DIRECTION_VECTORS[@bearing]
    @x += vector[0]
    @y += vector[1]
  end

  private
  def turn(dir_offset)
    turn_to = DIRECTIONS.index(@bearing) + dir_offset
    @bearing = DIRECTIONS[turn_to % 4]
  end

end
