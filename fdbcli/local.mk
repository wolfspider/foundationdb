#
# local.mk
#
# This source file is part of the FoundationDB open source project
#
# Copyright 2013-2018 Apple Inc. and the FoundationDB project authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# -*- mode: makefile; -*-

fdbcli_CFLAGS := $(fdbclient_CFLAGS)
fdbcli_LDFLAGS := $(fdbrpc_LDFLAGS)
fdbcli_LIBS := lib/libfdbclient.a lib/libfdbrpc.a lib/libflow.a $(FDB_TLS_LIB)
fdbcli_STATIC_LIBS := $(TLS_LIBS)

fdbcli_GENERATED_SOURCES += versions.h

ifeq ($(PLATFORM),linux)
  fdbcli_LDFLAGS += -static-libstdc++ -static-libgcc -lpthread -lrt -ldl
else ifeq ($(PLATFORM),freebsd)
  fdbcli_LDFLAGS += -lc++ -lm -lpthread -lexecinfo -ldevstat
else ifeq ($(PLATFORM),osx)
  fdbcli_LDFLAGS += -lc++
endif

test_fdbcli_status: fdbcli
	python scripts/test_status.py

bin/fdbcli.debug: bin/fdbcli
