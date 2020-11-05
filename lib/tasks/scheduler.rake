require 'rake'
namespace :course do
  desc "This task is called by the Heroku scheduler add-on"
  task :sync => :environment do
    puts "Starting sync"
    CoursesWorker.sync
    puts "Sycn completed."
  end
end