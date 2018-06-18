require 'bundler/gem_tasks'
require 'rake/testtask'
require 'yard'
require 'witei_web_api'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
  t.ruby_opts << if ENV['HELL_ENABLED']
    '-W2'
  else
    '-W1'
  end
end

YARD::Rake::YardocTask.new do |t|
  t.files = ['lib/**/*.rb']
end

task default: :test

task :console do
  exec "irb -r witei_web_api -I ./lib"
end

task :build do
  exec 'gem build witei_web_api.gemspec'
end

task :push do
  exec "gem push witei_web_api-#{WiteiWebApi::VERSION}.gem"
end

# We're not going to yank on a regular basis, but this is how it's done if you
# really want a task for that for some reason.

# task :yank do
#   exec "gem yank witei_web_api -v #{WiteiWebApi::VERSION}"
# end
