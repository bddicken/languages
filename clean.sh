#!/bin/bash

# Clean all generated files in subdirectories
find . -type f -name '*code' -delete
find . -type f -name '*.lock' -delete
find . -type f -name '*.dwarf' -delete
find . -type f -name '*.hi' -delete
find . -type f -name '*.o' -delete
find . -type f -name '*.bun-build' -delete
find . -type f -name '*.class' -delete
find . -type f -name '*.jar' -delete
find . -type d -name 'code' -exec rm -Rrf {} +
find . -type d -name 'bin' -exec rm -rf {} +
find . -type d -name 'obj' -exec rm -rf {} +
find . -type d -name 'bun' -exec rm -rf {} +
find . -type d -name 'target' -exec rm -rf {} +
find . -type d -name '.scala-build' -exec rm -rf {} +
find . -type d -name 'build' -exec rm -rf {} +

echo "Cleaned all generated files."