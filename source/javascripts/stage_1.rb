class Stage1
  def display_code
    <<-CODE
puts "Hello \#{name}"
    CODE
  end

  def code
    <<-TEST
puts "Hello \#{name}"
true
    TEST
  end

  def next_stage
    Stage2.new
  end
end
