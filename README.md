# stable
python wrapper for alpha stable distributions in C++

![master](https://github.com/gobrewers14/pystable/workflows/master/badge.svg)

## Docker
### build image
```shell
$ make build-image
```

### pull pre-built image
```shell
$ docker pull demiurge/stable:latest
```

### build
```shell
$ make build
```

### install
```shell
# run the docker image in the project root
$ docker run --rm -it \
  `pwd`:/app \
  -w /app \
  demiurge/stable:latest \
  /bin/bash
$ python ./setup.py develop
```

### example
```shell
root@8044a2d130a4:~# python
>>> import stable
>>> import numpy as np
>>>
>>> z = np.random.normal(0, 1, 1000)
>>> d = stable.alpha_stable_fit(z)
>>> print(d)
{
  'mu': 0.04784171761871786,
  'sigma': 0.7193377102627662,
  'alpha': 2.0,
  'beta': 0.0
}
```
