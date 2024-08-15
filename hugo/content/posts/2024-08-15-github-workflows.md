---
lastmod: "2024-08-15T17:51:00.0000000+01:00"
author: patrick
date: "2024-08-15T17:51:00.0000000+01:00"
title: New GitHub workflows
summary: I've made a GitHub workflow to assert that all required GitHub checks are complete, and one to publish and attest NuGet packages.
---

# [all-required-checks-complete](https://github.com/Smaug123/all-required-checks-complete-action)

The problem this solves is that GitHub's "required" checks are not actually required.
A "required" step which is skipped because it depends on a failed step will count as successful.
(This is folklore, but [here's one writeup](https://emmer.dev/blog/skippable-github-status-checks-aren-t-really-required/).)

# [publish-nuget](https://github.com/Smaug123/publish-nuget-action) 

NuGet [does not lend itself](https://github.com/NuGet/NuGetGallery/issues/10026) to [GitHub artefact attestation](https://docs.github.com/en/actions/security-for-github-actions/using-artifact-attestations/using-artifact-attestations-to-establish-provenance-for-builds), so there's some annoying work to do to make that happen.
This action performs that work!
