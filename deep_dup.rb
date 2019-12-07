# Suppor for deep dup - arrays for now
module DeepDup
  def deep_dup_arr(arr)
    return [] if arr.length.zero?

    innerArr = []

    arr.each do |el|
      if el.is_a?(Array)
        innerArr << deep_dup(el)
      else
        innerArr << el
      end
    end

    innerArr
  end
end
