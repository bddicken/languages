from Cython.Build import cythonize
from setuptools import Extension, setup

package = Extension("fib_f", ["pyx/*.pyx"])
setup(ext_modules=cythonize([package]))
