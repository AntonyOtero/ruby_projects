# 0,1,1,2,3,5,8,13,21,34,55,89,144
module Fibonacci
  def Fibonacci.fibs(num)
    fib_seq = [0, 1]

    return [] if num <= 0
    return [0] if num == 1

    for i in 0...num - 2 
      fib_seq << fib_seq[i] + fib_seq[i + 1]
    end
    fib_seq
  end

  def Fibonacci.fibs_rec(num, fib_seq=[0,1])
    return fib_seq.slice(0, num) if num <= 2
    fibs_rec(num - 1, fib_seq)
    fib_seq << fib_seq[-2] + fib_seq[-1]
  end
end
