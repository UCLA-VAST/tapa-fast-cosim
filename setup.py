from setuptools import find_packages, setup

setup(
    name='tapa-fast-cosim',
    version='0.0.20220816.dev1',
    description='',
    long_description='Fast cosim of HLS-generated RTL',
    long_description_content_type='text/markdown',
    url='https://github.com/Licheng-Guo/tapa-fast-cosim',
    author='Licheng Guo',
    classifiers=[
        'Development Status :: 2 - Pre-Alpha',
        'Intended Audience :: Developers',
        'Intended Audience :: Science/Research',
        'Programming Language :: Python :: 3 :: Only',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.6',
        'Programming Language :: Python :: 3.7',
        'Programming Language :: Python :: 3.8',
        'Programming Language :: Python :: 3.9',
        'Topic :: System :: Hardware',
    ],
    packages=find_packages(),
    python_requires='>=3.6',
    install_requires=[],
    entry_points={
        'console_scripts': [],
    },
)
