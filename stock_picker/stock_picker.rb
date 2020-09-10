require 'pry'

def best_sell(stock_array)
    highest = {:cost => 0, :day => 0}

    stock_array.each_with_index do |cost, day|
        if(cost > highest[:cost] and day != 0)
            highest[:cost] = cost
            highest[:day] = day
        end
    end
    highest
end

def best_buy(stock_array)
    lowest = best_sell(stock_array)

    stock_array.each_with_index do |cost, day|
        if(cost < lowest[:cost] and day < lowest[:day])
            lowest[:cost] = cost
            lowest[:day] = day
        end
    end
    lowest
end

def stock_picker(stock_array)
    lowest = best_buy(stock_array)
    highest = best_sell(stock_array)

    p [lowest[:day], highest[:day]]
end

stock_picker([17,3,6,9,15,8,6,1,10])


