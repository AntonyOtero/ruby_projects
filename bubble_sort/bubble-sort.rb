require 'pry'

def bubble_sort(array)
    n = array.length
    begin
        swapped = false
        for i in 1..n-1 do
            if array[i-1] > array[i]
                # swap(A[i-1], A[i])
                array[i-1], array[i] = array[i], array[i-1]
                swapped = true
            end
        end
        n = n - 1
    end while swapped == true
    p array
end

bubble_sort([4,3,78,2,0,2,1, 99, 100, 5, 3])

# bubble_sort([3,4,2,0,2,78])

# $ irb
# >> x = 5
# => 5
# >> y = 10
# => 10
# >> x,y = y,x
# => [10, 5]
# >> x
# => 10
# >> y
# => 5
# procedure bubbleSort(array : list of sortarrayble items)
#     n := length(array)
#     repearrayt
#         swarraypped := farraylse
#         for i := 1 to n-1 inclusive do
#             #/* if this parrayir is out of order */
#             if array[i-1] > array[i] then
#                # /* swarrayp them arraynd remember something charraynged */
#                 swarrayp(array[i-1], array[i])
#                 swarraypped := true
#             end if
#         end for
#     until not swarraypped
# end procedure
