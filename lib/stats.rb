module Stats
  module_function

  def roundrobin(l)
    Enumerator.new do |yielder|
      l.each_with_index do |row, i|
        l.drop(i + 1).each do |col|
          yielder << [row, col]
        end
      end
    end
  end

  def jaccard_index(set1, set2)
    n_or  = (set1 | set2).length
    n_and = (set1 & set2).length

    if n_or == 0 || n_and == 0
      0.0
    else
      n_and.to_f() / n_or.to_f()
    end
  end
end
