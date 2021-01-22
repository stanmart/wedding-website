from setuptools import setup, find_packages

with open("requirements.txt") as reqs:
    requirements = reqs.readlines()

setup(
    name="wedding-website",
    version="1.0.0",
    packages=find_packages(),
    install_requires=requirements
)
