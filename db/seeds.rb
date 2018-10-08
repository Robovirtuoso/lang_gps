puts "Creating languages"

File.foreach(Rails.root.join('db', 'languages.txt'), "\n") do |language|
  Language.create(name: language.strip)
end

puts"Creating study_habits"

%w(Listening Reading Speaking Writing).each do |type|
  StudyHabit.create(name: type)
end
