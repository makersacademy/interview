class Stage2
  def display_code
    <<-CODE
puts "Hello \#{upper(name)}"
    CODE
  end

  def code
    <<-TEST
puts "Hello \#{upper(name)}"
upper('asdf') == 'ASDF'
    TEST
  end

  def instructions
    <<-INSTR
Well done!</br></br>
Now please implement a method called upper that will make a string in all capitals
    INSTR
  end  

  def next_stage
    Stage3.new
  end
end
