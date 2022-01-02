/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef AZEROTHCORE_CRYPTO_GENERICS_HPP
#define AZEROTHCORE_CRYPTO_GENERICS_HPP

#include "BigNumber.h"
#include "CryptoRandom.h"
#include "Define.h"
#include "Errors.h"
#include <iterator>
#include <vector>

namespace Acore::Impl
{
    struct CryptoGenericsImpl
    {
        template <typename Cipher>
        static auto GenerateRandomIV() -> typename Cipher::IV
        {
            typename Cipher::IV iv;
            Acore::Crypto::GetRandomBytes(iv);
            return iv;
        }

        template <typename Container>
        static void AppendToBack(std::vector<uint8>& data, Container const& tail)
        {
            data.insert(data.end(), std::begin(tail), std::end(tail));
        }

        template <typename Container>
        static void SplitFromBack(std::vector<uint8>& data, Container& tail)
        {
            ASSERT(data.size() >= std::size(tail));
            for (size_t i = 1, N = std::size(tail); i <= N; ++i)
            {
                tail[N - i] = data.back();
                data.pop_back();
            }
        }
    };
}

namespace Acore::Crypto
{
    template <typename Cipher>
    void AEEncryptWithRandomIV(std::vector<uint8>& data, typename Cipher::Key const& key)
    {
        using IV = typename Cipher::IV;
        using Tag = typename Cipher::Tag;
        // select random IV
        IV iv = Acore::Impl::CryptoGenericsImpl::GenerateRandomIV<Cipher>();
        Tag tag;

        // encrypt data
        Cipher cipher(true);
        cipher.Init(key);
        bool success = cipher.Process(iv, data.data(), data.size(), tag);
        ASSERT(success);

        // append trailing IV and tag
        Acore::Impl::CryptoGenericsImpl::AppendToBack(data, iv);
        Acore::Impl::CryptoGenericsImpl::AppendToBack(data, tag);
    }

    template <typename Cipher>
    void AEEncryptWithRandomIV(std::vector<uint8>& data, BigNumber const& key)
    {
        AEEncryptWithRandomIV<Cipher>(data, key.ToByteArray<Cipher::KEY_SIZE_BYTES>());
    }

    template <typename Cipher>
    auto AEDecrypt(std::vector<uint8>& data, typename Cipher::Key const& key) -> bool
    {
        using IV = typename Cipher::IV;
        using Tag = typename Cipher::Tag;
        // extract trailing IV and tag
        IV iv;
        Tag tag;
        Acore::Impl::CryptoGenericsImpl::SplitFromBack(data, tag);
        Acore::Impl::CryptoGenericsImpl::SplitFromBack(data, iv);

        // decrypt data
        Cipher cipher(false);
        cipher.Init(key);
        return cipher.Process(iv, data.data(), data.size(), tag);
    }

    template <typename Cipher>
    auto AEDecrypt(std::vector<uint8>& data, BigNumber const& key) -> bool
    {
        return AEDecrypt<Cipher>(data, key.ToByteArray<Cipher::KEY_SIZE_BYTES>());
    }
}

#endif
