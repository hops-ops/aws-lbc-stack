### What's changed in v0.15.0

* chore(deps): update helm release aws-load-balancer-controller to v3.2.1 (#25) (by @renovate[bot])

  Co-authored-by: renovate[bot] <29139614+renovate[bot]@users.noreply.github.com>

* chore(deps): update helm release aws-load-balancer-controller to v3.2.2 (#26) (by @renovate[bot])

  Co-authored-by: renovate[bot] <29139614+renovate[bot]@users.noreply.github.com>

* chore(makefile): add generate-configuration target (by @patrickleet)

  Wires hops validate generate-configuration as a prerequisite of
  validate:all / validate / validate:% so configuration.yaml is
  regenerated from upbound.yaml before each validation run.

  Implements [[tasks/update-xrd-makefiles-generate-config]]

* feat(deps): update dependency aws-pod-identity to v0.10.1 (#27) (by @renovate[bot])

  Co-authored-by: renovate[bot] <29139614+renovate[bot]@users.noreply.github.com>


See full diff: [v0.14.0...v0.15.0](https://github.com/hops-ops/aws-base-stack/compare/v0.14.0...v0.15.0)
