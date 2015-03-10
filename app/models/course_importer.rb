class Course_importer

  def pull_data_from_api
    uri = URI("http://www.khanacademy.org/api/v1/topictree")
    request = Net::HTTP::Get.new(uri)
    response = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end
    data = JSON::parse(response.body)
  end

  def import(data)
    data["children"].each do |subject_data|
      new_subject = Subject.create({
        title: subject_data["title"],
        description: subject_data["description"]
      })

      subject_data["children"].each do |course|
        add_course(new_subject, course)
      end
    end
  end

  def add_course(subject, course_data)
    new_course = subject.courses.create({
      title: course_data["title"],
      description: course_data["description"]
    })

    if course_data.has_key?("children")
      course_data["children"].each do |exercise|
        new_course.exercises.create!({
          title: exercise["title"],
          description: exercise["description"]
        })
      end
    end
  end

  def runner
    data = pull_data_from_api
    import(data)
    true
  end
end
