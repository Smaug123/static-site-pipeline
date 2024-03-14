---
lastmod: "2024-04-14T00:12:00.0000000+00:00"
author: patrick
date: "2024-03-14T00:12:00.0000000+00:00"
title: YAML is not a superset of JSON
summary: "All the reasons I know for why YAML is not a superset of JSON."
categories:
- programming
---

I keep forgetting, so here we go.
Please let me know if you have any others!

## Treatment of e.g. `1e2`

JSON treats the value `1e2` a number, of course, because it's not in quote marks.
YAML fails to parse it as a number so silently falls back to treating it as a string.

```python
>>> import yaml
>>> import json

>>> yaml.safe_load('{"a": 1e2}')
{'a': '1e2'}

>>> json.loads('{"a": 1e2}')
{'a': 100.0}
```

## Tabs as indentation

YAML does not permit tabs to be used as indentation.

```python
>>> yaml.load ('{\n  "list": [\n    {},\n\t{}\n    ]\n}')
# yaml.scanner.ScannerError: while scanning for the next token
# found character '\t' that cannot start any token

>>> json.loads('{\n  "list": [\n    {},\n\t{}\n    ]\n}')
{'list': [{}, {}]}
```