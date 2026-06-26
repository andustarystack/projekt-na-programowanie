#!/bin/bash
sed 's/\(.*".*":.*\)/\/\/ \1\n\1/' en-7.2.json5 > pl-7.2.json5

diff --new-line-format="" --unchanged-line-format="" <(grep '"' en-7.4.json5) <(grep '"' en-7.2.json5) > pl-7.4.json5
