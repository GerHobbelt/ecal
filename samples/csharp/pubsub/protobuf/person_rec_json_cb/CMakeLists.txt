# ========================= eCAL LICENSE =================================
#
# Copyright (C) 2016 - 2019 Continental Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#      http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# ========================= eCAL LICENSE =================================

include(CSharpUtilities)
project(person_rec_json_cb_cs LANGUAGES CSharp)

find_package(eCAL REQUIRED)

set(minimal_rec_json_cb_cs_src
    person_rec_json_cb.cs
)

ecal_add_sample(${PROJECT_NAME} ${minimal_rec_json_cb_cs_src})

target_link_libraries(${PROJECT_NAME} Continental.eCAL.Protobuf person_protobufs_cs)

set_target_properties(${PROJECT_NAME} PROPERTIES
    VS_GLOBAL_ROOTNAMESPACE ${PROJECT_NAME}
    VS_DOTNET_TARGET_FRAMEWORK_VERSION "v4.6.1"
)

set_property(TARGET ${PROJECT_NAME}  PROPERTY
  VS_PACKAGE_REFERENCES "Google.Protobuf_${ECAL_CSHARP_PROTOBUF_VERSION}"
)

set_property(TARGET ${PROJECT_NAME} PROPERTY FOLDER samples/csharp/pubsub/protobuf)
