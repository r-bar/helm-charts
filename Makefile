CHART_MANIFESTS = $(shell find -name Chart.yaml)
CHARTS = $(patsubst %/Chart.yaml,%,${CHART_MANIFESTS})
CHART_FILES = $(shell find ${CHARTS} -type f)
ARCHIVES = $(shell find -maxdepth 1 -type f -name '*.tgz')
CHART_PIPLINES = $(shell find . -name pipeline.yaml ! -path './ci/*')


.PHONY: package
package: ${CHART_FILES}
	helm package ${CHARTS}
	make index.yaml

index.yaml: ${ARCHIVES}
	helm repo index ./


ci/full-pipeline.yaml: ci/pipeline.yaml ${CHART_PIPLINES}
	@python3 ci/merge-pipelines.py $^ | tee $@
