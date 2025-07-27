kubectl patch deployment flask-demo \
  -p '{"spec":{"template":{"spec":{"containers":[{"name":"flask-demo","env":[{"name":"MY_NODE_NAME","valueFrom":{"fieldRef":{"fieldPath":"spec.nodeName"}}}]}]}}}}'
