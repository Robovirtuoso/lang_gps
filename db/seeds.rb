puts "Creating languages"

File.foreach(Rails.root.join('db', 'languages.txt'), "\n") do |language|
  Language.create(name: language.strip)
end
