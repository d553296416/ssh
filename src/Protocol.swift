// Protocol.swift
// Copyright (c) 2024 ssh2.app
// Created by admin@ssh2.app 2024/8/21.

import Foundation

// 定义SessionDelegate协议，包含SSH会话相关的回调方法
public protocol SessionDelegate {
    /// 当SSH会话断开时调用
    func disconnect(ssh: SSH)

    /// 当SSH会话握手时调用
    func connect(ssh: SSH)

    /// 当需要键盘交互时调用，返回用户输入的字符串
    func keyboardInteractive(ssh: SSH, prompt: String) -> String

    /// 发送数据时调用，参数为发送数据的大小
    func send(ssh: SSH, size: Int)

    /// 接收数据时调用，参数为接收数据的大小
    func recv(ssh: SSH, size: Int)

    /// 输出调试信息
    func debug(ssh: SSH, message: String)

    /// 追踪SSH会话中的消息
    func trace(ssh: SSH, message: String)
}

// 定义ChannelDelegate协议，包含SSH通道相关的回调方法
public protocol ChannelDelegate {
    // 标准输出数据到达时调用
    func stdout(ssh: SSH, data: Data)
    // 标准错误输出数据到达时调用
    func dtderr(ssh: SSH, data: Data)
    // 通道断开时调用
    func disconnect(ssh: SSH)
    // 通道连接时调用
    func connect(ssh: SSH, online: Bool)
}

// 定义C语言风格的函数类型别名
typealias sendType = @convention(c) (libssh2_socket_t, UnsafeRawPointer, size_t, CInt, UnsafeRawPointer) -> ssize_t
typealias recvType = @convention(c) (libssh2_socket_t, UnsafeMutableRawPointer, size_t, CInt, UnsafeRawPointer) -> ssize_t
typealias disconnectType = @convention(c) (UnsafeRawPointer, CInt, UnsafePointer<CChar>, CInt, UnsafePointer<CChar>, CInt, UnsafeRawPointer) -> Void
typealias debugType = @convention(c) (UnsafeRawPointer, CInt, UnsafePointer<CChar>, CInt, UnsafePointer<CChar>, CInt, UnsafeRawPointer) -> Void