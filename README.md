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
- The generated test-case currently only contains nested rules.
- Testsystem: Core i7-3840QM @ 2.8 GHz (32GB RAM, Win 7)

```
libsass: < 520 ms (~470ms)
postcss: > 690 ms (~720ms)
```

:warning: Postcss finishes in `390ms` if **all** plugins were **disabled**.
In this case a `cat input.scss > output.css` should be even faster :wink:
But this is how postcss' [official benchmark] [1] works :confused:

Versions:
===

- Last update 11.11.2015
- node-sass @ 3.4.1
- postcss @ 5.0.11


[1]: https://github.com/postcss/benchmark