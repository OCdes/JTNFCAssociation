//
//  NFCTool.swift
//  Pods-JTNFCAssosiation_Example
//
//  Created by 袁炳生 on 2021/4/6.
//

import UIKit
import CoreNFC
@objc
public protocol NFCToolDelegate: NSObjectProtocol {
    func nfcSuccessfullyReaded(msg: String)
    func nfcFailureReaded(msg:String)
    func nfcSuccessfullyWrite(msg:String)
}

open class NFCTool: NSObject, NFCNDEFReaderSessionDelegate {
    enum ScanResultType: Int32 {
        case ScanResultTypeUnSupportDevice = 0
        case ScanResultTypeUnsupportSystem = 1
        case ScanResultTypeSuccess = 2
        case ScanResultTypeFail = 3
    }
    @objc open weak var delegate: NFCToolDelegate?
    public static let shareTool = NFCTool()
    private var isWrite = false
    private var contentStr: String = ""
    @available(iOS 11.0, *)
    public func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        if let d = self.delegate {
            DispatchQueue.main.async {
                d.nfcFailureReaded(msg: error.localizedDescription)
            }
        }
    }
    
    @available(iOS 11.0, *)
    public func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        var arr: [String] = []
        for message in messages {
            for record in message.records {
                let str = String(data: record.payload, encoding: .utf8) ?? ""
                arr.append(str)
            }
        }
        if let d = self.delegate {
            DispatchQueue.main.async {
                d.nfcSuccessfullyReaded(msg: (arr as NSArray).componentsJoined(by: ","))
            }
        }
        session.alertMessage = (arr as NSArray).componentsJoined(by: ",")
        session.invalidate()
    }
    
    @available(iOS 13.0, *)
    public func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        for tag in tags {
            session.connect(to: tag) { (error) in
                if error == nil {
                    if self.isWrite {
                        if let m = self.getWriteMessage(contentStr: self.contentStr) {
                            self.contentStr = ""
                            tag.writeNDEF(m) { (error) in
                                if error == nil {
                                    session.alertMessage = "写入成功"
                                    if let d = self.delegate {
                                        d.nfcSuccessfullyWrite(msg: "写入成功")
                                    }
                                } else {
                                    session.alertMessage = error?.localizedDescription ?? "写入失败"
                                    if let d = self.delegate {
                                        d.nfcSuccessfullyWrite(msg: session.alertMessage)
                                    }
                                }
                            }
                        }
                    } else {
                        tag.readNDEF { (message, error) in
                            if error == nil {
                                var arr: [String] = []
                                for record in message!.records {
                                    let str = String(data: record.payload, encoding: .utf8) ?? ""
                                    arr.append(str)
                                }
                                if let d = self.delegate {
                                    DispatchQueue.main.async {
                                        d.nfcSuccessfullyReaded(msg: (arr as NSArray).componentsJoined(by: ","))
                                    }
                                }
                                session.alertMessage = (arr as NSArray).componentsJoined(by: ",")
                            } else {
                                
                            }
                        }
                    }
                } else {
                    session.alertMessage = "标签未连接成功"
                }
            }
        }
        session.invalidate()
    }
    @available(iOS 11.0, *)
    private func getWriteMessage(contentStr: String)->(NFCNDEFMessage?) {
        let type = "U"
        let identifier = "1234444"
        let payloadStr = contentStr.count > 0 ? contentStr : "ahttps://cloud.hzjtyh.com"
        let typeData = type.data(using: .ascii)!
        let idData = identifier.data(using: .ascii)!
        let payloadData = payloadStr.data(using: .ascii)!
        if #available(iOS 13.0, *) {
            let payload = NFCNDEFPayload.init(format: .nfcWellKnown, type: typeData, identifier: idData, payload: payloadData)
            let message = NFCNDEFMessage.init(records: [payload])
            return message
        } else {
            // Fallback on earlier versions
            return nil
        }
    }
    
    @objc open func readData() {
        if #available(iOS 11.0, *) {
            if NFCNDEFReaderSession.readingAvailable {
                self.isWrite = false
                self.contentStr = ""
                let session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
                session.begin()
            } else {
                if let d = self.delegate {
                    d.nfcFailureReaded(msg: "您当前的设备不支持NFC功能")
                }
            }
            
        } else {
            // Fallback on earlier versions
            if let d = self.delegate {
                d.nfcFailureReaded(msg: "NFC读取功能需要您的系统版本在 iOS 11 +，请升级您的系统以使用此功能")
            }
        }
    }
    
    @objc open func autoReadData()->String {
        
        return ""
    }
    
    @objc open func writeData(contentStr: String) {
        if #available(iOS 11.0, *) {
            if NFCReaderSession.readingAvailable {
                let session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
                self.isWrite = true
                self.contentStr = contentStr;
                session.begin()
            } else {
                if let d = self.delegate {
                    d.nfcFailureReaded(msg: "您当前的设备不支持NFC功能")
                }
            }
            
        } else {
            // Fallback on earlier versions
            if let d = self.delegate {
                d.nfcFailureReaded(msg: "NFC读取功能需要您的系统版本在 iOS 11 +，请升级您的系统以使用此功能")
            }
        }
    }
    
    @objc open class func writeDataAndLock()->String {
        
        return ""
    }
}
