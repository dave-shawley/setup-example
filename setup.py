#!/usr/bin/env python

from setuptools import setup

import packagename


def read_requirements(req_file):
    reqs = []
    try:
        f = open(req_file)
        for line in f:
            if '#' in line:
                line = line[0 : line.find('#')]
            line = line.strip()
            if line:
                reqs.append(line)
        f.close()
    except IOError:
        pass
    return reqs

# read runtime requirements from a pip formatted requirements.txt
required_packages = read_requirements('requirements.txt')

# additional components used for testing are added in here
test_requirements = required_packages[:]
test_requirements.extend(read_requirements('test-requirements.txt'))

# and the top-level README becomes our packages long description
f = open('README.rst')
readme = f.read()
f.close()


# let setuptools.setup do the real work
setup(
    name='package-name',
    version=packagename.__version__,
    license='BSD',
    author='Dave Shawley',
    author_email='daveshawley@gmail.com',
    url='http://github.com/dave-shawley/setup-example/',
    description='Simple example of using Python toolchain',
    long_description=readme,
    packages=['packagename'],
    zip_safe=False,
    include_package_data=True,
    platforms='any',
    install_requires=required_packages,
    tests_require=test_requirements,
    test_suite='tests',
    classifiers=[
        'Intended Audience :: Developers',
        'License :: OSI Approved :: BSD License',
        'Operating System :: OS Independent',
        'Programming Language :: Python',
    ]
)

