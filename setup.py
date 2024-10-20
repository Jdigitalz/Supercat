#!/usr/bin/env python
# -*- coding: utf-8 -*-
from setuptools import setup

setup(
    name='supercat',
    version='0.1.0',
    py_modules=['supercat'],  
    install_requires=[
        'rich',  
    ],
    entry_points={
        'console_scripts': [
            'supercat = supercat:main',  
        ],
    },
    # Optionally specify where to install the package
    options={
        'install': {
            'prefix': '/usr',
        }
    },
)

