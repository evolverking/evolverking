def max_sum_subarray(arr, k):
    # Check if the array size is smaller than k
    if len(arr) < k:
        print("Invalid input: array size is smaller than k")
        return None

    # Calculate the sum of the first window
    max_sum = sum(arr[:k])
    window_sum = max_sum

    # Slide the window from start to end of the array
    for i in range(len(arr) - k):
        # Slide the window by removing the first element and adding the next element
        window_sum = window_sum - arr[i] + arr[i + k]
        max_sum = max(max_sum, window_sum)

    return max_sum

# Example usage
arr = [1, 3, 5, 2, 8, 10, 5]
k = 3
result = max_sum_subarray(arr, k)
print(f"The maximum sum of any subarray of size {k} is: {result}")
