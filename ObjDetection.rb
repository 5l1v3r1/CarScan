require 'ANImage'
require 'ANGlob'

class ObjDetection

	attr_reader :street
	attr_reader :objects
	attr_reader :cars

	def initialize(_image)
		@image = _image
		@street = ANGlob.new
		@scanned = ANGlob.new
		@objects = Array.new
		@cars = Array.new
	end

	def scan()
		scanStreet()
		scanObjects()
		scanCars()
	end

	def scanStreet()
		for y in (0..@image.height - 1)
			for x in (0..@image.width - 1)
				pix = @image.get_pixel(x, y)
				if pix.red > 160 && pix.green > 160 && pix.blue > 160
					@street.add(x, y)
					@scanned.add(x, y)
				end
			end
		end
	end

	def scanObjects()
		for y in (0..@image.height - 1)
			for x in (0..@image.width - 1)
				next if @scanned.include?(x, y)
				obj = ANGlob.new()
				scanAround(x, y, obj)
				@objects << obj
			end
		end
	end

	def scanCars()
		@objects.each { |obj|
			bounds = obj.bounds()
			if bounds['width'] > 5 && bounds['width'] < @image.width / 2
				if bounds['height'] > 5 && bounds['height'] < @image.height / 2
					if !obj.hasLines()
						@cars << obj
					end
				end
			end
		}
	end

	private

	def scanAround(_xval, _yval, object)
		scanPoints = Array.new
		scanPoints << [_xval, _yval]

		while scanPoints.length > 0
			point = scanPoints[0]
			scanPoints.delete_at(0)
			x, y = point[0], point[1]
			next if @scanned.include?(x, y)
			@scanned.add(x, y)
			object.add(x, y)
			minY = y > 0 ? y - 1 : 0
			minX = x > 0 ? x - 1 : 0
			maxY = y < @image.height - 1 ? y + 1 : y
			maxX = x < @image.width - 1 ? x + 1 : x
			for _x in (minX..maxX)
				for _y in (minY..maxY)
					scanPoints << [_x, _y]
				end
			end
		end
		return object
	end

end
