TAG?=


.PHONY: release
release: ## Issues a release
	@test -n "$(TAG)" || (echo "The TAG variable must be set" && exit 1)
	@echo "Releasing $(TAG)"
	git checkout -b "release-$(TAG)"
	sed -i -E s/v[0-9]+\.[0-9]+\.[0-9]+/$(TAG)/ charts/audittail/templates/_values.tpl
	git add charts/audittail/templates/_values.tpl
	git commit -m "Release $(TAG)"
	git tag -m "Release $(TAG)" "$(TAG)"
	git push origin "release-$(TAG)"
	git push origin "$(TAG)"
