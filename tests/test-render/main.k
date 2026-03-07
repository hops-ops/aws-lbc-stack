import models.io.upbound.dev.meta.v1alpha1 as metav1alpha1
import models.k8s.apimachinery.pkg.apis.meta.v1 as metav1

# ==============================================================================
# Unit tests for helm.aws LoadBalancerController XRD
# ==============================================================================

_items = [
    # ==========================================================================
    # Test 1: Minimal input renders Helm Release and Pod Identity
    # ==========================================================================
    metav1alpha1.CompositionTest {
        metadata.name = "minimal-renders-helm-and-pod-identity"
        spec = {
            compositionPath = "apis/bases/composition.yaml"
            xrdPath = "apis/bases/definition.yaml"
            timeoutSeconds = 60
            validate = False
            xr = {
                apiVersion = "stacks.aws.hops.ops.com.ai/v1alpha1"
                kind = "Base"
                metadata.name = "test-alb"
                spec = {
                    clusterName = "test-cluster"
                    aws = {
                        region = "us-east-1"
                    }
                }
            }
            assertResources = [
                {
                    apiVersion = "helm.m.crossplane.io/v1beta1"
                    kind = "Release"
                    metadata.name = "test-alb"
                    spec.forProvider.values.clusterName = "test-cluster"
                }
                {
                    apiVersion = "aws.hops.ops.com.ai/v1alpha1"
                    kind = "PodIdentity"
                    metadata.name = "test-alb"
                    spec = {
                        clusterName = "test-cluster"
                        region = "us-east-1"
                        serviceAccount = {
                            name = "aws-load-balancer-controller"
                            namespace = "kube-system"
                        }
                    }
                }
            ]
        }
    }

    # ==========================================================================
    # Test 2: Custom labels are applied to both resources
    # ==========================================================================
    metav1alpha1.CompositionTest {
        metadata.name = "custom-labels-applied-to-both"
        spec = {
            compositionPath = "apis/bases/composition.yaml"
            xrdPath = "apis/bases/definition.yaml"
            timeoutSeconds = 60
            validate = False
            xr = {
                apiVersion = "stacks.aws.hops.ops.com.ai/v1alpha1"
                kind = "Base"
                metadata.name = "labeled-alb"
                spec = {
                    clusterName = "test-cluster"
                    labels = {
                        team = "platform"
                    }
                    aws = {
                        region = "us-east-1"
                    }
                }
            }
            assertResources = [
                {
                    apiVersion = "helm.m.crossplane.io/v1beta1"
                    kind = "Release"
                    metadata = {
                        name = "labeled-alb"
                        labels = {
                            "hops.ops.com.ai/managed" = "true"
                            "hops.ops.com.ai/loadbalancercontroller" = "labeled-alb"
                            team = "platform"
                        }
                    }
                }
                {
                    apiVersion = "aws.hops.ops.com.ai/v1alpha1"
                    kind = "PodIdentity"
                    metadata = {
                        name = "labeled-alb"
                        labels = {
                            "hops.ops.com.ai/managed" = "true"
                            "hops.ops.com.ai/loadbalancercontroller" = "labeled-alb"
                            team = "platform"
                        }
                    }
                }
            ]
        }
    }

    # ==========================================================================
    # Test 3: AWS rolePrefix propagates to PodIdentity
    # ==========================================================================
    metav1alpha1.CompositionTest {
        metadata.name = "aws-role-prefix-propagates"
        spec = {
            compositionPath = "apis/bases/composition.yaml"
            xrdPath = "apis/bases/definition.yaml"
            timeoutSeconds = 60
            validate = False
            xr = {
                apiVersion = "stacks.aws.hops.ops.com.ai/v1alpha1"
                kind = "Base"
                metadata.name = "prefixed-alb"
                spec = {
                    clusterName = "prod-cluster"
                    aws = {
                        region = "us-west-2"
                        rolePrefix = "prod-"
                    }
                }
            }
            assertResources = [
                {
                    apiVersion = "aws.hops.ops.com.ai/v1alpha1"
                    kind = "PodIdentity"
                    metadata.name = "prefixed-alb"
                    spec = {
                        rolePrefix = "prod-"
                        serviceAccount = {
                            namespace = "kube-system"
                        }
                    }
                }
            ]
        }
    }

    # ==========================================================================
    # Test 4: Default namespace is kube-system
    # ==========================================================================
    metav1alpha1.CompositionTest {
        metadata.name = "default-namespace-kube-system"
        spec = {
            compositionPath = "apis/bases/composition.yaml"
            xrdPath = "apis/bases/definition.yaml"
            timeoutSeconds = 60
            validate = False
            xr = {
                apiVersion = "stacks.aws.hops.ops.com.ai/v1alpha1"
                kind = "Base"
                metadata.name = "ns-test"
                spec = {
                    clusterName = "test-cluster"
                    aws = {
                        region = "us-east-1"
                    }
                }
            }
            assertResources = [
                {
                    apiVersion = "helm.m.crossplane.io/v1beta1"
                    kind = "Release"
                    metadata.name = "ns-test"
                    spec.forProvider.namespace = "kube-system"
                }
            ]
        }
    }
]

items = _items
