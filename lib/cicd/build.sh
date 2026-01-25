# shellcheck shell=bash

######################################################################
#<
#
# Function: p6_cicd_build_run([dockerfile=Dockerfile])
#
#  Args:
#	OPTIONAL dockerfile - Dockerfile path [Dockerfile]
#
#>
#/ Synopsis
#/    Builds the current directory with Docker using the given Dockerfile.
######################################################################
p6_cicd_build_run() {
  local dockerfile="${1:-Dockerfile}" # Dockerfile path

  docker -l debug build --no-cache --progress plain -f "$dockerfile" .
}
