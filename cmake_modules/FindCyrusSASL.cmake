# Copyright (c) 2013, Cloudera, inc.
# All rights reserved.
#
# - Find Cyrus SASL (sasl.h, libsasl2.a -- NOT libsasl2.so)
# - Find Cyrus SASL plugins (sasl2/libplain.so, sasl2/libanonymous.so)
# - NOTE that the plugins must exist on the local system. Cyrus SASL is hard-coded to
#   look in the system path for plugin libraries. While this is something that can be
#   overridden at runtime, for security reasons it makes sense not to statically link
#   the plugin libraries so that administrators can more easily patch security issues.
# This module defines
#  CYRUS_SASL_INCLUDE_DIR, directory containing headers
#  CYRUS_SASL_STATIC_LIB, path to libsasl2.a
#  CYRUS_SASL_ANON_DYN_LIB, path to sasl2/libanonymous.so
#  CYRUS_SASL_PLAIN_DYN_LIB, path to sasl2/libplain.so
#  CYRUS_SASL_FOUND, whether Cyrus SASL and its plugins have been found

set(CYRUS_SASL_SEARCH_HEADER_PATHS
  ${THIRDPARTY_PREFIX}/include
)

set(CYRUS_SASL_SEARCH_LIB_PATH
  ${THIRDPARTY_PREFIX}/lib
)

find_path(CYRUS_SASL_INCLUDE_DIR sasl/sasl.h PATHS
  ${CYRUS_SASL_SEARCH_HEADER_PATHS}
  # make sure we don't accidentally pick up a different version
  NO_DEFAULT_PATH
)

find_library(CYRUS_SASL_STATIC_LIB NAMES libsasl2.a PATHS ${CYRUS_SASL_SEARCH_LIB_PATH} NO_DEFAULT_PATH)
find_library(CYRUS_SASL_PLAIN_DYN_LIB NAMES sasl2/libplain.so)    # look on system path
find_library(CYRUS_SASL_ANON_DYN_LIB NAMES sasl2/libanonymous.so) # look on system path

if (CYRUS_SASL_STATIC_LIB AND CYRUS_SASL_PLAIN_DYN_LIB AND CYRUS_SASL_ANON_DYN_LIB)
  set(CYRUS_SASL_FOUND TRUE)
else ()
  set(CYRUS_SASL_FOUND FALSE)
endif ()

if (CYRUS_SASL_FOUND)
  if (NOT CYRUS_SASL_FIND_QUIETLY)
    message(STATUS "Cyrus SASL Found: ${CYRUS_SASL_STATIC_LIB}")
    message(STATUS "Cyrus SASL Plugins Found: ${CYRUS_SASL_PLAIN_DYN_LIB};${CYRUS_SASL_ANON_DYN_LIB}")
  endif ()
else ()
  message(STATUS "Cyrus SASL includes and libraries NOT found. "
    "Looked for headers in ${CYRUS_SASL_SEARCH_HEADER_PATH}, "
    "and for libs in ${CYRUS_SASL_SEARCH_LIB_PATH} as well as system paths")
endif ()

mark_as_advanced(
  CYRUS_SASL_INCLUDE_DIR
  CYRUS_SASL_STATIC_LIB
  CYRUS_SASL_PLAIN_DYN_LIB
  CYRUS_SASL_ANON_DYN_LIB
)
