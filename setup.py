from setuptools import find_packages, tests, setup
from pip.req import parse_requirements
import os
import codecs

def local_file(file):
  return codecs.open(
    os.path.join(os.path.dirname(__file__), file), 'r', 'utf-8'
  )

install_reqs = [
  line.strip()
  for line in local_file('requirements.txt').readlines()
  if line.strip() != ''
]

version_file = os.path.join(os.path.dirname(__file__), 'VERSION')
with open(version_file) as fh:
    pp_version = fh.read().strip()

setup(
  name="perf-script-postprocessor",
  version=pp_version,
  author="Archit Sharma",
  author_email="archit.py@gmail.com",
  description="Tool for analyzing output of perf tool: `$ perf script`",
  license = "GPL v3",
  keywords = "python perf analysis",
  url="https://github.com/arcolife/perf-script-postprocessor",
  install_requires=install_reqs,
  scripts=['bin/perf_script_processor', 'bin/delta_processor'],
  packages = find_packages(),
  package_data = {'perf-script-postprocessor': ['VERSION']},
  zip_safe=False,
  long_description = local_file('README.md').read(),
  #test_suite="tests",
  classifiers = [
    'Development Status :: 3 - Alpha',
    'Topic :: Software Development :: Libraries',
    'License :: OSI Approved :: GNU General Public License v3 (GPLv3)',
    'Programming Language :: Python',
    'Intended Audience :: Developers'
    ]
)
