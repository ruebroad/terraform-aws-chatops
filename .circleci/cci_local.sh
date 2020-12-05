#!/bin/bash
circleci config validate
circleci local execute --job shellcheck
circleci local execute --job terraform

# https://circleci.com/blog/local-pipeline-development/
# https://circleci.com/docs/2.0/local-cli/