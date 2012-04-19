DataMapper::Model.raise_on_save_failure = true
DataMapper.setup(:default, "mysql://cdion:password@127.0.0.1")
DataMapper.setup(:in_memory, :adapter => "in_memory")
