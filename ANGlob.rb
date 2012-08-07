class ANGlob

	def initialize()
		@xvals = Hash.new
	end

	def include?(x, y)
		if @xvals[x]
			arr = @xvals[x]
			return arr.include?(y)
		end
		return false
	end

	def add(x, y)
		if @xvals[x]
			arr = @xvals[x]
			arr << y if !arr.include?(y)
		else
			arr = Array.new
			@xvals[x] = arr
			arr << y
		end
	end

	def bounds()
		minX, minY, maxX, maxY = 10000, 10000, 0, 0
		each_point { |x, y|
			minX = x if x < minX
			maxX = x if x > maxX
			minY = y if y < minY
			maxY = y if y > maxY
		}
		puts "width #{maxX - minX} height #{maxY - minY}"
		return {'x' => minX, 'y' => minY,
				'width' => 1 + maxX - minX,
				'height' => 1 + maxY - minY}
	end

	def hasLines(width=4, length=5)
		#TODO: proportional line detection here
		lineCount = 0
		@xvals.each { |x, ys|
			if ys.length <= width
				lineCount += 1
			else
				lineCount = 0
			end
			return true if lineCount >= length
		}

		lineCount = 0
		xs_for_ys().each { |y, xs|
			if xs.length <= width
				lineCount += 1
			else
				lineCount = 0
			end
			return true if lineCount >= length
		}

		return false
	end

	def each_point()
		@xvals.each { |x, ys|
			ys.each { |y|
				yield(x, y)
			}
		}
	end

	private

	def xs_for_ys()
		dict = Hash.new
		each_point { |x, y|
			arr = dict[y]
			if !arr
				arr = Array.new
				dict[y] = arr
			end
			arr << x
		}
		return dict
	end

end
