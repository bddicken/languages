from Cython.Build import cythonize
from setuptools import Extension, setup

package = Extension("loops_f", ["pyx/*.pyx"])
setup(ext_modules=cythonize([package]))
