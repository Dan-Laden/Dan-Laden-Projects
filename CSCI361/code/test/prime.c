#include <stdlib.h>
#include <stdio.h>

int check_prime(int test_value) {

    if (test_value < 2) return 0;
    if (test_value == 2) return 1;

    int i;
    for (i = 2; i < test_value; i++)
        if ((test_value % i) == 0) return 0;

    return 1;
}

int main() {

    int test_value = 179424673;

    if (check_prime(test_value)) printf("%i is prime.\n", test_value);
    else printf("%i is not prime.\n", test_value);

    return 0;
}