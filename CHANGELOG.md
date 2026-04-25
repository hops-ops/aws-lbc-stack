### What's changed in v1.1.0

* feat: spec.aws.vpcId, fullnameOverride, unique Usage name (by @patrickleet)

  Three fixes uncovered by deploying onto a real EKS cluster:

  - Add spec.aws.vpcId so the ALB controller doesn't depend on IMDS
    (EKS nodes default IMDSv2 to hop-limit=1, which blocks pod IMDS
    access). When provided, vpcId flows into the chart values.

  - Set fullnameOverride/nameOverride defaults so the deployment is
    always named 'aws-load-balancer-controller' instead of
    '<release>-aws-load-balancer-controller'. Matches what the README
    has always claimed; the template was just missing the values.

  - Make the Usage name unique per stack family
    ('<name>-delete-helm-lbc-before-pod-identity'), so it doesn't
    collide with sibling stacks (e.g. aws-secret-stack) that share the
    same XR metadata.name and produced the same Usage name, leading to
    an invalid double 'controller: true' ownerReference.


See full diff: [v1.0.0...v1.1.0](https://github.com/hops-ops/aws-lbc-stack/compare/v1.0.0...v1.1.0)
