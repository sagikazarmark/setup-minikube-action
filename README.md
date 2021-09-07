# Set up minikube action

[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/sagikazarmark/setup-minikube-action/CI?style=flat-square)](https://github.com/sagikazarmark/setup-minikube-action/actions?query=workflow%3ACI)

**GitHub Action to install [minikube](https://minikube.sigs.k8s.io).**


## Usage

Add the following **after** your checkout step:

```yaml
- name: Set up minikube
  uses: sagikazarmark/setup-minikube-action@v0

- name: Launch minikube cluster
  run: minikube start
```


### Inputs

Following inputs can be used as `step.with` keys

| Name                | Type    | Description                        |
|---------------------|---------|------------------------------------|
| `version`           | String  | The minikube version to use. |


> <sup>*</sup> Required fields


## License

The MIT License (MIT). Please see [License File](LICENSE) for more information.
