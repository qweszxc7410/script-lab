# 04.sh
# 功能：請補上腳本的功能說明
# 用途：請補上腳本的實際用途
kubectl patch deployment flask-demo \
  -p '{"spec":{"template":{"spec":{"containers":[{"name":"flask-demo","env":[{"name":"MY_NODE_NAME","valueFrom":{"fieldRef":{"fieldPath":"spec.nodeName"}}}]}]}}}}'