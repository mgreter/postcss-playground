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
sass-nested: 1.292s
postcss-nested: 1.451s
sass-extend: 0.0694s
postcss-extend: 4.037s
```

:warning: Postcss finishes in `390ms` if **all** plugins were **disabled**.
In this case a `cat input.scss > output.css` should be even faster :wink:
But this is how postcss' [official benchmark] [1] works :confused:

Versions:
===

- Last update 20.12.2016
- node-sass @ 4.1.1
- postcss @ 5.2.6
- postcss-extend @ 1.0.5
- postcss-nested @ 1.0.0


[1]: https://github.com/postcss/benchmark