class Array

  # fill an array with the given elements right;
  #   arr = [1, 2, 3]
  #   arr.rjust! 5, nil
  #   # => [1, 2, 3, nil, nil]
  def rjust!(n, x)
    return self if n < length
    insert(0, *Array.new([0, n-length].max, x))
  end

  ##
  #   arr = [1, 2, 3]
  #   arr.ljust! 5, nil
  #   # => [nil, nil, 1, 2, 3]
  def ljust!(n, x)
    return self if n < length
    fill(x, length...n)
  end

  ##
  #   arr = [1, 2, 3]
  #   arr.mjust!(5, nil)
  #   # => [1, 2, nil, nil, 3]
  def mjust!(n, x)
    return self if n < length
    insert((length / 2.0).ceil, *Array.new(n - length, x))
  end

  ##
  # combine the same key hash like array
  #   raw_data = [
  #     { a: 1 },
  #     { a: 2 },
  #     { b: 2 }
  #   ]
  #   raw_data.to_combined_hash
  #   #=> { a: [1, 2], b: 2 }
  def to_combined_h
    self.reduce({}) do |memo, obj|
      memo.merge(obj) { |_, old_val, new_val| (Array(old_val) + Array(new_val)).uniq }
    end
  end
  alias_method :to_combined_hash, :to_combined_h

  #
  # raw_data = [
  #   [:a, 1],
  #   [:a, 2, 3],
  #   [:b, 2]
  # ]
  # raw_data.to_combined_h
  # #=> [ { a: 1 }, { a: 2 }, { b: 2 } ]
  def to_array_h
    self.map { |x, y| { x => y } }
  end
  alias_method :to_array_hash, :to_array_h

  # 2D array to csv file
  #   data = [
  #     [1, 2],
  #     [3, 4]
  #   ]
  #   data.to_csv_file
  def to_csv_file(file = 'export.csv')
    CSV.open(file, 'w') do |csv|
      self.each { |ar| csv << ar }
    end
  end

end
