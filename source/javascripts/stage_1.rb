class Stage1
  def display_code
    <<-CODE
puts "Hello \#{name}"
    CODE
  end

  def code
    <<-TEST
puts "Hello \#{name}"
name =~ /[a-zA-Z]+/
    TEST
  end

  def instructions
    <<-INSTR
please make this code run by assigning a string of your name to the variable 'name'
    INSTR
  end

  def next_stage
    Stage2.new
  end
end
