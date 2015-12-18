class Stage2
  def display_code
    <<-CODE
puts "Hello \#{upper(name)}"
    CODE
  end

  def code
    <<-TEST
puts "Hello \#{upper(name)}"
true
    TEST
  end
end
