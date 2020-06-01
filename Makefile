CHART_MANIFESTS = $(shell find -name Chart.yaml)
CHARTS = $(patsubst %/Chart.yaml,%,${CHART_MANIFESTS})
CHART_FILES = $(shell find ${CHARTS} -type f)
ARCHIVES = $(shell find -maxdepth 1 -type f -name '*.tgz')


.PHONY: package
package: ${CHART_FILES}
	helm package ${CHARTS}
	make index.yaml

index.yaml: ${ARCHIVES}
	helm repo index ./
