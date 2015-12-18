class Stage3
  def display_code
    <<-CODE
puts "Hello \#{lower(name)}"
    CODE
  end

  def code
    <<-TEST
puts "Hello \#{lower(name)}"
lower('ASDF') == 'asdf'
    TEST
  end

  def instructions
    <<-INSTR
Well done!</br></br>
Now please implement a method called lower that will make a string in all lower case
    INSTR
  end  

  def next_stage
    Stage4.new
  end
end
