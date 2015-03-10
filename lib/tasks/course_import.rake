namespace :import do
  desc 'Imports the TopicTree from Khan Academy'
  task :topic_tree => [:environment] do
    CourseImporter.run
  end
end
