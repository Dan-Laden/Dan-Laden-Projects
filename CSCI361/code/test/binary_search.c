#include <stdlib.h>
#include <stdio.h>

int array[6] = {0, 1, 2, 3, 4, 5};
int array_length = sizeof(array)/sizeof(array[0]);
int search_item = 6;

int binary_search(int start, int end) {
    if (start == end)
        return array[start] == search_item;

    int middle_offset = (end-start)/2;
    int middle_index = start+mid;
    int middle_value = array[middle_index];

    if (middle_value == search_item)
        return 1;
    else if (middle_value < search_item)
        return binary_search(middle_index+1, end);
    else if (middle_value > search_item)
        return binary_search(start, middle_index);
}

int main() {

    printf("%i\n", binary_search(0, array_length-1));

    return 0;
}
