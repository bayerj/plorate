#! /usr/bin/env python
# -*- coding: utf-8 -*-


__author__ = 'Justin Bayer, bayer.justin@googlemail.com'


from setuptools import setup, find_packages


setup(
    name="plorate",
    version="pre-0.1",
    description="plorate for machine learning",
    license="BSD",
    keywords="Machine Learning plotting",
    packages=find_packages(exclude=['examples', 'docs']),
    include_package_data=True,
)

