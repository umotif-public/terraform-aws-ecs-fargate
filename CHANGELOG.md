# Change Log

All notable changes to this project will be documented in this file.

<a name="unreleased"></a>
## [Unreleased]

- removed whitespace
- added distinct function to prevent a port being used multiple times
- Added checks to ensure that errors are not generated when target_group ports mapping is used
- Updated variable name
- Updated file to prefer target_group ports if provided, else use task_container_port


<a name="6.4.2"></a>
## [6.4.2] - 2022-03-11

- Refactor examples to work with provider 4.0.0+ ([#53](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/53))
- fix: setting `task_health_command` to null ([#49](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/49))


<a name="6.4.1"></a>
## [6.4.1] - 2021-12-11

- Break down task health check into two variables ([#48](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/48))


<a name="6.4.0"></a>
## [6.4.0] - 2021-10-20

- Add ephemeral_storage ([#47](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/47))


<a name="6.3.0"></a>
## [6.3.0] - 2021-09-30

- Added pseudo_terminal attribute ([#45](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/45))


<a name="6.2.2"></a>
## [6.2.2] - 2021-08-20

- Make deregistration_delay attribute customizable for ALB Target Groups ([#42](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/42))


<a name="6.2.1"></a>
## [6.2.1] - 2021-07-30

- Add support to pick latest task definition ([#41](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/41))


<a name="6.2.0"></a>
## [6.2.0] - 2021-06-04

- add tags iam role ([#34](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/34))


<a name="6.1.0"></a>
## [6.1.0] - 2021-05-10

- Add support for enable_execute_command ([#33](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/33))


<a name="6.0.0"></a>
## [6.0.0] - 2021-02-09

- Add missing 'target_group_name' parameter in examples ([#31](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/31))
- Add support for registering multiple target groups with a service ([#29](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/29))
- Update README.md


<a name="5.1.0"></a>
## [5.1.0] - 2020-12-09

- update docs
- Add secrets to task defintion ([#28](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/28))


<a name="5.0.1"></a>
## [5.0.1] - 2020-12-04

- Potential fix to the issue ([#26](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/26))


<a name="5.0.0"></a>
## [5.0.0] - 2020-11-04

- Upgrades ([#24](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/24))


<a name="4.0.3"></a>
## [4.0.3] - 2020-10-13

- Update main.tf ([#23](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/23))


<a name="4.0.2"></a>
## [4.0.2] - 2020-10-02

- Fix log group permissions ([#22](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/22))


<a name="4.0.1"></a>
## [4.0.1] - 2020-08-05

- Feature/v3 provider support ([#21](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/21))


<a name="4.0.0"></a>
## [4.0.0] - 2020-08-03

- Update README.md
- Add full for volume configuration ([#20](https://github.com/umotif-public/terraform-aws-ecs-fargate/issues/20))


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


[Unreleased]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/6.4.2...HEAD
[6.4.2]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/6.4.1...6.4.2
[6.4.1]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/6.4.0...6.4.1
[6.4.0]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/6.3.0...6.4.0
[6.3.0]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/6.2.2...6.3.0
[6.2.2]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/6.2.1...6.2.2
[6.2.1]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/6.2.0...6.2.1
[6.2.0]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/6.1.0...6.2.0
[6.1.0]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/6.0.0...6.1.0
[6.0.0]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/5.1.0...6.0.0
[5.1.0]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/5.0.1...5.1.0
[5.0.1]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/5.0.0...5.0.1
[5.0.0]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/4.0.3...5.0.0
[4.0.3]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/4.0.2...4.0.3
[4.0.2]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/4.0.1...4.0.2
[4.0.1]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/4.0.0...4.0.1
[4.0.0]: https://github.com/umotif-public/terraform-aws-ecs-fargate/compare/3.0.2...4.0.0
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
