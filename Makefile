# Must be set before doing a release
TAG?=

# Enable debug logging for plugin-tester image
TEST_DEBUG?=
ifdef TEST_DEBUG
	TTY_FLAG = -t
else
	TTY_FLAG =
endif



.PHONY: release
release: ## Issues a release
	@test -n "$(TAG)" || (echo "The TAG variable must be set" && exit 1)
	@echo "Releasing $(TAG)"
	git checkout -b "release-$(TAG)"
	sed -i "s%$(PLUGIN_REF).*:%$(PLUGIN_REF)#$(TAG):%" README.md
	git add README.md
	git commit -m "Release $(TAG)"
	git tag -m "Release $(TAG)" "$(TAG)"
	git push origin "release-$(TAG)"
	git push origin "$(TAG)"
