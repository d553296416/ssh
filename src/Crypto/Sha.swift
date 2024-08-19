// Sha.swift
// Copyright (c) 2024 ssh2.app
// Created by admin@ssh2.app 2024/8/18.

import Foundation
import wolfSSL

public extension Crypto {
    /// 使用指定的算法对字符串进行SHA哈希计算
    /// - Parameters:
    ///   - message: 需要进行哈希计算的字符串
    ///   - algorithm: 哈希算法
    /// - Returns: 哈希计算后的Data对象
    func sha(_ message: String, algorithm: Algorithm) -> Data {
        sha(message.pointerCChar, message_len: message.count, algorithm: algorithm)
    }

    /// 使用指定的算法对Data对象进行SHA哈希计算
    /// - Parameters:
    ///   - message: 需要进行哈希计算的Data对象
    ///   - algorithm: 哈希算法
    /// - Returns: 哈希计算后的Data对象
    func sha(_ message: Data, algorithm: Algorithm) -> Data {
        sha(message.pointerCChar, message_len: message.count, algorithm: algorithm)
    }

    // sha 函数用于计算给定消息的 SHA 算法哈希值
    // - message: 消息的原始指针
    // - message_len: 消息的长度
    // - algorithm: 使用的 SHA 算法
    /// - Returns: 哈希计算后的Data对象
    func sha(_ message: UnsafeRawPointer, message_len: Int, algorithm: Algorithm) -> Data {
        let buffer = UnsafeMutablePointer<Int8>.allocate(capacity: algorithm.digest)
        let len = UnsafeMutablePointer<UInt32>.allocate(capacity: algorithm.digest)
        defer {
            buffer.deallocate()
            len.deallocate()
        }
        let mdctx = wolfSSL_EVP_MD_CTX_new()
        wolfSSL_EVP_DigestInit(mdctx, algorithm.EVP)
        wolfSSL_EVP_DigestUpdate(mdctx, message, message_len)
        wolfSSL_EVP_DigestFinal_ex(mdctx, buffer, len)
        wolfSSL_EVP_MD_CTX_free(mdctx)
        return Data(bytes: buffer, count: Int(len.pointee))
    }
}