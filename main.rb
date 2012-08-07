require 'ANImage'
require 'ObjDetection'

# scan the image
puts "Scanning image for objects and cars..."
image = ANImage.new('img/D6Cam093.jpg')
obj = ObjDetection.new(image)
obj.scan()
puts "Got #{obj.objects.count} objects"
puts "Got #{obj.cars.count} cars"

# highlight cars red
puts "Highlighting cars..."
color = ANPixel.new(255, 0, 0)
for object in obj.cars
	object.each_point { |x, y|
		image.set_pixel(x, y, color)
	}
end

# write the highlighted file
path = 'img/carsdetected.png'
File.unlink(path) if File.exists?(path)
image.write(path)
