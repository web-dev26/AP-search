module IsearchesHelper

class Find
	
	def tree_data(users)
		@users = users
		@tree = Tree.new(@users, 4)
	end

	def search(input)
		@tree.find(input)
	end
end

class Tree
	attr_reader :tree_root
	attr_reader :obj

	def initialize(obj, fields)
		@tree_root = Node.new(fields).parse(obj)
	end
	
	def find(input)
		@obj = []
		search(input, @tree_root)
        @obj
	end

	def search(input, node)
		fld = node.fld
		med = node.location.send(fld)
		range = input[fld]
		if (range.nil? and node.left) or (node.left and (med >= range.begin))
			search(input, node.left)
		end
		if (range.nil? and node.right) or (node.right and (med <= range.end))
			search(input, node.right)
		end
		if input.all? {|f, r| r.cover? node.location.send(f)}
			@obj << node.location
		end
	end
end

class Node
	attr_reader :left, :right
	attr_reader :location
	attr_reader :fld
	FLD = {0 => :age, 1 => :salary, 2 => :height, 3 => :weight}

	def initialize(fields, location=nil, left=nil, right=nil)
		@fields = fields
		@location = location
		@left = left
		@right = right
	end

	def parse(obj, deep = 0)
		fld = deep % @fields
		@fld = FLD[fld]
		obj = obj.sort_by{|obj| obj.send(@fld)}
		half = obj.length / 2
		@location = obj[half]
		@left = Node.new(@fields).parse(obj[0..half-1], deep+1) unless half < 1
		@right = Node.new(@fields).parse(obj[half+1..-1], deep+1) unless half+1 >= obj.length
		self
	end
end

end
