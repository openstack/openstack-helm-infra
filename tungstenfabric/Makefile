
HELM := helm
FILTER_CHARTS := helm-toolkit-tf
TUNGSTEN_FABRIC_CHARTS := $(FILTER_CHARTS) $(filter-out $(FILTER_CHARTS), $(patsubst %/Chart.yaml, %, $(wildcard */Chart.yaml)))
BUILD_CHARTS := $(foreach chart, $(TUNGSTEN_FABRIC_CHARTS), build-$(chart))

.phony: all

all: $(BUILD_CHARTS)

build-%: lint-% init-%
	@echo "========================================="
	@echo "      helm pack	$*     "
	@echo "========================================="
	if [ -f $*/Chart.yaml ]; then $(HELM) package $*; fi

lint-%: init-%
	@echo "===================================="
	@echo "      helm lint	$*     "
	@echo "===================================="
	if [ -f $*/Chart.yaml ]; then $(HELM) lint $*; fi

init-%:
	@echo "============================================="
	@echo " helm dependency update	$* "
	@echo "============================================="
	if [ -f $*/requirements.yaml -a -f $*/Chart.yaml ]; then $(HELM) dep up $*; fi

clean:
	rm -rf *.tgz
	rm -rf */charts
	rm -rf */*.lock
