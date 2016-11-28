# DynamicArray

Ruby implementation of a dynamic array with:
- O(1) push
- O(1) pop
- O(1) shift
- O(1) unshift
- O(1) []
- O(1) []=

## Details

- Dynamic array is built on top of a StaticArray class which mimics the behavior of a Static C array.
- Utilizes a ring buffer to make shift and unshift on constant time possible
