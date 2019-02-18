#!/usr/bin/env python3

def test_prime(test_value):

    if test_value == 2:
        return 1

    for x in range(2, test_value):
        if test_value % x == 0:
            return 0

    return 1

def main():
    test_value = 179424673

    if test_prime(test_value):
        print(test_value, "is prime.")
    else:
        print(test_value, "is not prime.")

if __name__ == '__main__':
    main()