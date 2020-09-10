# on input of n elements
#   if n < 2
#     return
#   else
#     sort left half of elements
#     sort right half of elements
#     merge sorted halves

def merge_sort(arr)
  return arr if arr.length < 2

  h = arr.length / 2
  left_half = arr.slice(0, h)
  right_half = arr.slice(h, arr.length)
  merged_arr = (merge_sort(left_half).concat(merge_sort(right_half))).sort
end

p merge_sort([4, 8, 6, 2, 1, 7, 5])