module Tournament
  def self.tally(input)
    Report.new(
      Parser.new(input).teams
    ).to_s
  end

  class Parser
    def initialize(input)
      @input = input.strip
    end

    def negate_status(status)
      return "draw" if status == "draw"

      status == "win" ? "loss" : "win"
    end

    def each_team(line)
      team1, team2, status = line.split(";")
      yield(team1, status)
      # second team has the opposite status as the first
      yield(team2, negate_status(status))
    end

    def teams
      @teams = {}

      @input.each_line(chomp: true) do |line|
        next if line.empty?

        each_team(line) do |team, status|
          team = find_team(team)
          case status
          when "win"  then team.win!
          when "loss" then team.loss!
          when "draw" then team.draw!
          end
        end
      end
      @teams.values
    end

    def find_team(name)
      @teams[name] ||= Team.new(name)
    end
  end

  class Team
    attr_reader :name, :wins, :losses, :played, :draws

    def initialize(name)
      @name = name
      @wins = @losses = @draws = @played = 0
    end

    def play!
      @played += 1
    end

    def win!
      play!
      @wins += 1
    end

    def loss!
      play!
      @losses += 1
    end

    def draw!
      play!
      @draws += 1
    end

    def points
      wins * 3 + draws
    end

    def to_h
      {
        name: name,
        played: played,
        wins: wins,
        losses: losses,
        draws: draws,
        points: points
      }
    end
  end

  class Report
    HEADER = "Team                           | MP |  W |  D |  L |  P\n".freeze
    ROW_TEMPLATE = "%<name>-30.30s | %<played> d | %<wins> d | %<draws> d | %<losses> d | %<points> d\n"
    private_constant :HEADER
    private_constant :ROW_TEMPLATE

    def initialize(teams)
      @teams = teams
    end

    def to_s
      HEADER +
        sorted_teams
          .map(&method(:row)).join("")
    end

    private

    attr_reader :teams

    def row(team)
      format(ROW_TEMPLATE, team.to_h)
    end

    def sorted_teams
      teams.sort_by { |x| [-x.points, x.name] }
    end
  end
end