### What's changed in v1.5.1

* fix: add load balancer controller resource defaults (#35) (by @patrickleet)

  Summary:
  - Add explicit resource requests/limits for aws-load-balancer-controller.
  - Merge chart defaults with user-supplied Helm values so overrides still work.
  - Cover defaults in render tests.

* chore(deps): update unbounded-tech/workflow-vnext-tag action to v1.21.3 (#32) (by @renovate[bot])

  Co-authored-by: renovate[bot] <29139614+renovate[bot]@users.noreply.github.com>


See full diff: [v1.5.0...v1.5.1](https://github.com/hops-ops/aws-lbc-stack/compare/v1.5.0...v1.5.1)
