# priority queue
# maxを返すにはPQ.new(ar,:max)
class PQ
  attr_accessor :q
  def initialize(ar,mode=:min)
    @q = []
    @mode = mode
    ar.each{|a| push(a)}
  end

  # 末尾を先頭に持ってきて入れ替え
  def pop
    return nil if @q.size.zero?
    return @q.pop if @q.size==1

    ans = @q[0]
    @q[0] = @q.pop
    down
    ans
  end

  # 末尾に入れて入れ替え
  def push(item)
    @q.push(item)
    up
  end

  private

  # 末尾の要素が小さければ上に入れ替え
  def up
    idx = @q.size-1
    while idx!=0 do
      pi = parent_i(idx)
      parent = @q[pi]
      break if compare_eq(parent,@q[idx])
      swap(idx,pi)
      idx = pi
    end
  end

  # 先頭を下に入れ替え
  def down
    idx = 0
    while idx*2+1 < @q.size do
      # 子より大きいなら入れ替え。左右の子のうち、小さい方。
      lci = idx*2+1
      rci = idx*2+2
      lc = @q[lci]
      rc = @q[rci]

      # 左しか子がない
      if rci==@q.size
        break if compare_eq(@q[idx],lc)
        swap(idx,lci)
        idx = lci
      # 子が2つある
      else
        break if compare_eq(@q[idx],selector(lc,rc))
        if compare_eq(lc,rc)
          swap(idx,lci)
          idx = lci
        else
          swap(idx,rci)
          idx = rci
        end
      end
    end
  end

  def compare_eq(a,b)
    case @mode
    when :min
      a<=b
    when :max
      a>=b
    end
  end

  def selector(a,b)
    case @mode
    when :min
      min(a,b)
    when :max
      max(a,b)
    end
  end

  def parent_i(idx) (idx-(idx.odd? ? 1 : 2))/2 end
  def min(a,b) a<=b ? a : b end
  def max(a,b) a>=b ? a : b end
  def swap(i1,i2) @q[i1],@q[i2]=@q[i2],@q[i1] end
end

# aa=[8,2,5,4,8,2,9]
# pq=PQ.new(aa)
# puts pq.q.to_s
# 7.times do
#   pq.pop
#   puts pq.q.to_s
# end

# pq2=PQ.new(aa,:max)
# puts pq2.q.to_s
# 7.times do
#   pq2.pop
#   puts pq2.q.to_s
# end