class School
  def initialize()
    @classes = Hash.new { |h,k| h[k] = [] }
  end

  def add(name, grade)
    @classes[grade].push name
    @classes[grade].sort!
  end

  def students(grade)
    @classes[grade]
  end

  def students_by_grade
    @classes.sort_by {|k,_| k}.map do |k,v|
      { grade: k, students: v }
    end
  end
end
