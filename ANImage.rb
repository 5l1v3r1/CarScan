$LOAD_PATH << '/var/lib/gems/1.8/gems/rmagick-2.13.1/lib'
require 'RMagick'
include Magick

class ANPixel

	attr_reader :red
	attr_reader :green
	attr_reader :blue

	def ANPixel.val(array, index)
		red = (array[index].to_f / 256.0).floor
		green = (array[index + 1].to_f / 256.0).floor
		blue = (array[index + 2].to_f / 256.0).floor
		return ANPixel.new(red, green, blue)
	end

	def initialize(r, g, b)
		@red = r
		@green = g
		@blue = b
	end

	def to_s()
		return "#{@red}, #{@green}, #{@blue}"
	end

	def to_str()
		return to_s
	end

end

class ANImage

	attr_reader :pixels
	attr_reader :width
	attr_reader :height

	def initialize(filename)
		list = ImageList.new(filename).cur_image
		image = list.cur_image
		values = image.export_pixels
		@pixels = Array.new
		@width = image.columns
		@height = image.rows
		index = 0
		for y in (0..@height - 1)
			for x in (0..@width - 1)
				pixel = ANPixel.val(values, index)
				index += 3
				@pixels << pixel
			end	
		end
	end

	def get_pixel(x, y)
		return @pixels[x + (y * @width)]
	end

	def set_pixel(x, y, pixel)
		@pixels[x + (y * @width)] = pixel
	end

	def write(filename)
		pixelData = Array.new
		for p in @pixels
			pixelData << p.red * 256
			pixelData << p.green * 256
			pixelData << p.blue * 256
		end
		img = Image.new(@width, @height)
		img.import_pixels(0, 0, @width, @height, 'RGB', pixelData)
		img.write(filename)
	end

end
