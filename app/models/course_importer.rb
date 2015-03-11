class CourseImporter

  def self.pull_data_from_api
    uri = URI("http://www.khanacademy.org/api/v1/topictree")
    request = Net::HTTP::Get.new(uri)
    response = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end
    data = JSON::parse(response.body)
  end

  def self.import(data)
    data["children"].each_with_index do |subject_data, index|
      if ( index > 0 && index < 3 ) || index == 5
        new_subject = Subject.create({
          title: subject_data["title"],
          description: subject_data["description"]
        })
        subject_data["children"].each do |course|
          add_course(new_subject, course)
        end
      end
    end
  end

  def self.add_course(subject, course_data)
    new_course = subject.courses.create({
      title: course_data["title"],
      description: course_data["description"]
    })
    course_data['children'].each do |topic_data|
      add_topic(new_course, topic_data)
    end
  end

  def self.add_topic(course, topic_data)
    if topic_data.has_key?('children')
      topic_data['children'].each do |sub_topic_data|
        if sub_topic_data.has_key?('children')
          sub_topic_data['children'].each do |exercise|
            course.exercises.create(
              title: exercise['title'], 
              description: exercise['description']
            )
          end
        else
          course.exercises.create(
              title: sub_topic_data['title'], 
              description: sub_topic_data['description']
            )
        end
      end
    else
      course.exercises.create(
              title: topic_data['title'], 
              description: topic_data['description']
            )
    end
  end
      
  def self.run
    data = pull_data_from_api
    import(data)
    true
  end

end
