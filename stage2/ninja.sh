cd src/ninja

set -e

python configure.py --bootstrap

install ninja /usr/bin

set +e
