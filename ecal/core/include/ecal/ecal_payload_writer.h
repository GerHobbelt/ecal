/* ========================= eCAL LICENSE =================================
 *
 * Copyright (C) 2016 - 2019 Continental Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * ========================= eCAL LICENSE =================================
*/

/**
 * @file   ecal_payload_writer.h
 * @brief  eCAL payload writer base class
**/

#pragma once

#include <cstddef>

namespace eCAL
{
  /**
   * @brief Base payload writer class to allow zero copy memory operations.
   *
   * This class serves as the base class for payload writers, allowing zero-copy memory
   * operations. The `Write` and `Update` calls may operate on the target memory file
   * directly in zero-copy mode.
   */
  class CPayloadWriter
  {
  public:
    /**
     * @brief Default constructor for CPayloadWriter.
     */
    CPayloadWriter() = default;

    /**
     * @brief Virtual destructor for CPayloadWriter.
     */
    virtual ~CPayloadWriter() = default;

    /**
     * @brief Copy constructor (deleted).
     */
    CPayloadWriter(const CPayloadWriter&) = default;

    /**
     * @brief Move constructor (deleted).
     */
    CPayloadWriter(CPayloadWriter&&) = default;

    /**
     * @brief Copy assignment operator (deleted).
     */
    CPayloadWriter& operator=(const CPayloadWriter&) = default;

    /**
     * @brief Move assignment operator (deleted).
     */
    CPayloadWriter& operator=(CPayloadWriter&&) = default;

    /**
     * @brief Perform a full write operation with uninitialized memory.
     *
     * This virtual function allows derived classes to perform a full write operation
     * when the provisioned memory is uninitialized.
     *
     * @param buffer_ Pointer to the buffer containing the data to be written.
     * @param size_   Size of the data to be written.
     *
     * @return True if the write operation is successful, false otherwise.
     */
    virtual bool Write(void* buffer_, size_t size_) = 0;

    /**
     * @brief Perform a partial write operation or modify existing data.
     *
     * This virtual function allows derived classes to perform a partial write operation
     * or modify existing data when the provisioned memory is already initialized and
     * contains the data from the last write operation. By default, this operation will
     * just call the `Write` function.
     *
     * @param buffer_ Pointer to the buffer containing the data to be written or modified.
     * @param size_   Size of the data to be written or modified.
     *
     * @return True if the write/update operation is successful, false otherwise.
     */
    virtual bool Update(void* buffer_, size_t size_) { return Write(buffer_, size_); };

    /**
     * @brief Get the size of the required memory.
     *
     * This virtual function allows derived classes to provide the size of the memory
     * that eCAL needs to allocate.
     *
     * @return The size of the required memory.
     */
    virtual size_t GetSize() = 0;
  };

} // namespace eCAL
