#!/bin/bash

oc project openshift-infra

for i in $(oc get secret | egrep "(hawkular|heapster|metrics)" | awk '{ print $1 }'); do
  oc delete secret $i
done

oc delete rc hawkular-metrics heapster hawkular-cassandra-1
oc delete svc hawkular-cassandra hawkular-cassandra-nodes hawkular-metrics heapster 
oc delete route hawkular-metrics
oc delete sa cassandra hawkular heapster
oc delete template hawkular-cassandra-node-emptydir hawkular-cassandra-node-pv hawkular-cassandra-services hawkular-heapster hawkular-metrics hawkular-support
oc delete pvc metrics-cassandra-1
