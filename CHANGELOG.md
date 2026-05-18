### What's changed in v1.3.0

* chore(deps): update helm release aws-load-balancer-controller to v3.3.0 (#29) (by @renovate[bot])

  Co-authored-by: renovate[bot] <29139614+renovate[bot]@users.noreply.github.com>

* feat: Burstable resource defaults for aws-load-balancer-controller (by @patrickleet)

  Chart ships BestEffort by default. Verified on pat-local: both
  aws-load-balancer-controller-7b8b77b65d pods transitioned to Burstable
  QoS with requests cpu=50m memory=128Mi, limits cpu=200m memory=256Mi.

  Implements [[tasks/cluster-wide-resource-right-sizing-p95-observation]] tier-1 #6


See full diff: [v1.2.0...v1.3.0](https://github.com/hops-ops/aws-lbc-stack/compare/v1.2.0...v1.3.0)
