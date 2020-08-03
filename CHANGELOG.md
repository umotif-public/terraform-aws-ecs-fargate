# Change Log

All notable changes to this project will be documented in this file.

<a name="unreleased"></a>
## [Unreleased]



<a name="3.0.2"></a>
## [3.0.2] - 2020-07-30

- Add task definition and execution role outputs  ([#19](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/19))


<a name="3.0.1"></a>
## [3.0.1] - 2020-06-23

- Update variables.tf


<a name="3.0.0"></a>
## [3.0.0] - 2020-05-22

- Lock minimum version of provider and add force_new_deployment ([#18](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/18))
- update changelog and versions


<a name="2.0.0"></a>
## [2.0.0] - 2020-05-20

- Improve security group creation/deletion and switch to using prefix ([#17](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/17))


<a name="1.4.0"></a>
## [1.4.0] - 2020-05-11

- Add full support for volumes and container timeouts ([#16](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/16))
- update CHANGELOG.md


<a name="1.3.0"></a>
## [1.3.0] - 2020-05-04

- Fix task private repository credentials variable issue ([#14](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/14))
- Feature/updates ([#13](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/13))


<a name="1.2.0"></a>
## [1.2.0] - 2020-04-14

- Add support for additional variables and configuration options. ([#12](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/12))


<a name="1.1.1"></a>
## [1.1.1] - 2020-03-19

- lb_target reference fix


<a name="1.1.0"></a>
## [1.1.0] - 2020-03-19

- Feature/task healthcheck ([#11](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/11))
- Add support for FARGATE-SPOT capacity provider and extend options for task definition ([#10](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/10))
- add git hooks and update docs ([#9](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/9))


<a name="1.0.9"></a>
## [1.0.9] - 2020-01-31

- Feature/encrypt logs ([#8](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/8))


<a name="1.0.8"></a>
## [1.0.8] - 2020-01-14

- Feature/healthcheck grace fix ([#7](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/7))


<a name="1.0.7"></a>
## [1.0.7] - 2020-01-10

- Feature/lb toggle ([#6](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/6))


<a name="1.0.6"></a>
## [1.0.6] - 2020-01-09

- fix format
- doh! ([#5](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/5))


<a name="1.0.5"></a>
## [1.0.5] - 2020-01-09

- Feature/improve tg naming ([#4](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/4))


<a name="1.0.4"></a>
## [1.0.4] - 2020-01-09

- Feature/fix dynamic port mapping ([#3](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/3))


<a name="1.0.3"></a>
## [1.0.3] - 2020-01-08

- fix format and update docs


<a name="1.0.2"></a>
## [1.0.2] - 2020-01-08

- improve tag support and expose host port ([#1](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/1))


<a name="1.0.1"></a>
## [1.0.1] - 2019-12-19

- improve docs and auto generating of inputs/outputs


<a name="1.0.0"></a>
## 1.0.0 - 2019-12-17

- add licence
- Add initial configuration for ecs fargate module
- Initial commit


[Unreleased]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/3.0.2...HEAD
[3.0.2]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/3.0.1...3.0.2
[3.0.1]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/3.0.0...3.0.1
[3.0.0]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/2.0.0...3.0.0
[2.0.0]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/1.4.0...2.0.0
[1.4.0]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/1.3.0...1.4.0
[1.3.0]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/1.2.0...1.3.0
[1.2.0]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/1.1.1...1.2.0
[1.1.1]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/1.1.0...1.1.1
[1.1.0]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/1.0.9...1.1.0
[1.0.9]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/1.0.8...1.0.9
[1.0.8]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/1.0.7...1.0.8
[1.0.7]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/1.0.6...1.0.7
[1.0.6]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/1.0.5...1.0.6
[1.0.5]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/1.0.4...1.0.5
[1.0.4]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/1.0.3...1.0.4
[1.0.3]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/1.0.2...1.0.3
[1.0.2]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/1.0.1...1.0.2
[1.0.1]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/1.0.0...1.0.1
