class Pagination
  DEFAULT = {
    data_count: 10
  }

  def initialize(data, offset)
    @pages = (data.count/Float(DEFAULT[:data_count])).ceil
    @offset_data = data.offset(offset*DEFAULT[:data_count]).limit(DEFAULT[:data_count])
  end

  def values
    [@pages, @offset_data]
  end
end
