config = YAML::load(File.open("#{Rails.root}/config/database.yml"))[Rails.env]
DataMapper::Model.raise_on_save_failure = true
DataMapper.setup(:default, "mysql://dev:mysql@127.0.0.1")
DataMapper.setup(:in_memory, :adapter => "in_memory")

class DataMapper::SaveFailureError
	def to_s
		super + " " + resource.errors.inspect
	end
end
