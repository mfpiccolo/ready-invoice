require "rake/testtask"

# run test and cane by default
task default: [:test, :cane]

Rake::TestTask.new(:test) do |t|
  t.libs << "lib"
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
  t.verbose = false
end
