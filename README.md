Run:
===
```
npm install
gulp postcss
gulp sass
```

Results:
===

- 10 runs each are measured and then the median is taken.
- Testsystem: Core i7-3630QM @ 2.4 GHz (16GB RAM, Win 10)

```
sass-nested: 1.146s
postcss-nested: 3.372s
sass-for-loop: 0.0403s
postcss-for-loop: 0.2059s
sass-extend: 0.0739s
postcss-extend: 4.302s
# old postcss-nested 1.0.1
postcss-nested: 1.451s
```

:exclamation: Huge difference (x2) between
postcss-nested version 1 and 2.

:warning: Postcss finishes in `390ms` if **all** plugins were **disabled**.
In this case a `cat input.scss > output.css` should be even faster :wink:
But this is how postcss' [official benchmark][1] works :confused:

Versions:
===

- Last update 20.12.2016
- node-sass @ 4.6.1
- postcss @ 6.0.14
- postcss-extend @ 1.0.5
- postcss-nested @ 2.1.2
- postcss-for @ 2.1.1


[1]: https://github.com/postcss/benchmark