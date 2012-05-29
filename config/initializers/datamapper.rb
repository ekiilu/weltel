DataMapper::Model.raise_on_save_failure = true
DataMapper.setup(:default, "mysql://cdion:password@127.0.0.1")
DataMapper.setup(:in_memory, :adapter => "in_memory")

class DataMapper::SaveFailureError
	def to_s
		super + " " + resource.errors.inspect
	end
end
