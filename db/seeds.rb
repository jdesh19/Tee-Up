require 'date'
TeeTime.destroy_all
GolfCourse.destroy_all

courses = GolfCourse.create([
  { name: "Pebble Beach Golf Links", holes: 18, location: "Pebble Beach, California, USA" },
  { name: "Banff Springs Golf Course", holes: 18, location: "Banff, Alberta, Canada" },
  { name: "Shadow Creek Golf Course", holes: 18, location: "North Las Vegas, Nevada, USA" },
  { name: "Winged Foot Golf Club", holes: 18, location: "Mamaroneck, New York, USA" }
])

start_date = Date.today
end_date = start_date + 1.year

start_time = DateTime.new(start_date.year, start_date.month, start_date.day, 7, 0)
end_time = start_time + 12.hours
interval_minutes = 15

current_date = start_date

while current_date <= end_date
  courses.each do |course|
    current_time = start_time

    while current_time < end_time
      tee_time = TeeTime.new(start_time: current_time, price: 4699, golf_course_id: course.id)
      unless tee_time.save
        puts tee_time.errors.full_messages
      end
      current_time += interval_minutes.minutes
    end
  end

  current_date += 1.day
  start_time = DateTime.new(current_date.year, current_date.month, current_date.day, 7, 0)
  end_time = start_time + 12.hours
end

puts "Created #{TeeTime.count} tee times."
