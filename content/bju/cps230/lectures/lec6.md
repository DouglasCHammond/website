---
title: "CPS 230"
date: 2018-08-21T00:00:00-04:00
draft: false
hasMath: true
---

# Lecture 6: Floating Point

Floating point numbers in 64-bit architectures are the same size as signed / unsigned integers (64-bits), but the layout of the bits is quite a bit different! There are three parts:

``` text
0 00000000000 0000000000000000000000000000000000000000000000000000
^           ^                                                    ^
Sign        Exponent                                      Mantissa
```

This is true unless they are single precision, in which case they are only 32-bit.

``` text
0 00000000 00000000000000000000000
^        ^                       ^
Sign     Exponent         Mantissa
```

Floating point numbers are written in scientific notation, so let's review that for a moment.

## Scientific Notation Reviewed

{{< tex "1.324 x 10^{3}" >}}

What does the above represent? 0.001324, 1324 or something else?

The answer is 1324.  In scientific notation numbers are written *first non-zero digit*.*remaining digits* x 10^*positions to move the decimal*.  If the reader needs to move the decimal right, then the exponent is positive, but if they need to move it left, then the exponent is negative.  You might be asking what the 10 is for?  The 10 represents that we are working with base 10 numbers!  So as you can probably guess, we can use scientific notation in others number bases as well, including binary.

## Scientific Notation: Binary Edition

If we are looking at a decimal number, each place is multiplied by a value (place / value) in order to reach the value desired.  This includes after the decimal point!

{{< tex "10^{3} 10^{2} 10^{1} 10^{0}.10^{-1} 10^{-2} 10^{-3}" >}} or {{< tex "10^{3} 10^{2} 10^{1} 10^{0}.\frac{1}{10} \frac{1}{100} \frac{1}{1000}" >}}

Binary is the same.  So if we wanted to represent {{< tex "\frac{1}{2}" >}} in binary, it would simply be 0.1.  If we wanted to represent {{< tex "\frac{1}{4}" >}}, it would be 0.01, and {{< tex "\frac{3}{4}" >}} would be 0.11.

## Floating Point Representation in Memory

Now back to floating points.  In floating point, we are representing a number using binary scientific notation.  The mantissa represents the part following the decimal (we can store up to 53 bits before truncation occurs or 22 bits in single precision).  Note: the leading one before the decimal is thrown out.  The exponent represents the exponent in the scientific notation representation, but it is biased at 1023 (127 for single precision, more on this in a bit).  Finally, the sign bit tells if the number is negative or positive.

So the floating point representation for 0.5 would be `0111111111110000000000000000000000000000000000000000000000000000`, or 1 x 2^-1, right?  Not quite, we need to talk about biases.  An exponent of 0x7FF (0xFF for single precision) and 0x0 are reserved for special values. 0x7FF / 0xFF represents infinitity with the sign bit telling you which infinity. 0x0 and a mantissa of 0 represent 0, but 0x0 with a non-0 mantissa represents NaN.  This means that an exponent of 0 is not 0x0 but 0x3FF / 0x7F.  So in reality 0.5 would be `0011111111100000000000000000000000000000000000000000000000000000` or `(0 1022 0)`.