
class DataInspect

  def self.version
    '0.0.2'
  end

  def self.hi
    puts "Hi from DataInspect!!"
    return 512
  end


  def self.readfile(file)
    reader = Reader.new(file)
    yield reader
  end

end


class Reader

  def initialize(file)
    @file = file
  end

  def each_byte
    offset = 0
    @file.each_byte do |byte|
      yield byte, offset
      offset += 1
    end
  end

end