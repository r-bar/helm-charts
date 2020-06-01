CHART_MANIFESTS = $(shell find -name Chart.yaml)
CHARTS = $(patsubst %/Chart.yaml,%,${CHART_MANIFESTS})
CHART_FILES = $(shell find ${CHARTS} -type f)


index.yaml: ${CHART_FILES}
	helm repo index ${CHARTS}
