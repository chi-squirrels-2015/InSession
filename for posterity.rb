data['children'][7]['children'][14]['children'][0]['children'][3]['children'][1]

data['children'].each_with_index do |subject, a|
    subject['children'].each_with_index do |course,b|
      if course.has_key?('children')
        course['children'].each_with_index do |topic,c|
          if topic.has_key?('children')
            topic['children'].each_with_index do |sub_topic,d|
              if sub_topic.has_key?('children')
                sub_topic['children'].each_with_index do |exercise,e|
                  puts "exercise - #{a}/#{b}/#{c}/#{d}/#{e} " + exercise['title'] if exercise['title'].include? "counting"
                end
              else
                puts "exercise - #{a}/#{b}/#{c}/#{d} " + sub_topic['title'] if sub_topic['title'] .include? "counting"
              end
            end
          else
            puts "exercise - #{a}/#{b}/#{c}/#{d}/#{e} " + topic['title'] if topic['title']. include? "counting"
          end
        end
      else
        puts "exercise - #{a}/#{b}/#{c}/#{d}/#{e} " + course['title'] if course['title']. include? "counting"
      end
    end
end ; 1
