#include <stdio.h>

int maxSumSubarray(int arr[], int n, int k) {
    // Check if the array size is smaller than k
    if (n < k) {
        printf("Invalid input: array size is smaller than k\n");
        return -1;
    }

    // Calculate the sum of the first window
    int max_sum = 0;
    for (int i = 0; i < k; i++)
        max_sum += arr[i];

    int window_sum = max_sum;

    // Slide the window from start to end of the array
    for (int i = 0; i < n - k; i++) {
        window_sum = window_sum - arr[i] + arr[i + k];
        if (window_sum > max_sum)
            max_sum = window_sum;
    }

    return max_sum;
}

int main() {
    int arr[] = {1, 3, 5, 2, 8, 10, 5};
    int k = 3;
    int n = sizeof(arr) / sizeof(arr[0]);
    int result = maxSumSubarray(arr, n, k);
    
    if (result != -1) {
        printf("The maximum sum of any subarray of size %d is: %d\n", k, result);
    }
    
    return 0;
}
