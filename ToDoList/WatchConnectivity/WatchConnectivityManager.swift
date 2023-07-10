//
//  WatchConnectivityManager.swift
//  ToDoList
//
//  Created by Lei on 2023/7/10.
//

import Foundation
import WatchConnectivity

final class WatchConnectivityManager: NSObject, ObservableObject {
    static let shared = WatchConnectivityManager()
    @Published var item: ToDoItem? = nil
    @Published var isError: Bool = false
    var errorMessage: String?
    
    private override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    private let itemDataKey = "item"
    
    func sendItem(_ item: ToDoItem) {
        guard WCSession.default.activationState == .activated else {
            return
        }
        #if os(iOS)
        guard WCSession.default.isWatchAppInstalled else {
            return
        }
        #else
        guard WCSession.default.isCompanionAppInstalled else {
            return
        }
        #endif
        
        guard let itemData = encodeItemData(item) else {
            return
        }
        
        WCSession.default.sendMessage([itemDataKey: itemData], replyHandler: nil) { [weak self] error in
            self?.isError = true
            self?.errorMessage = error.localizedDescription
        }
    }
    
    private func encodeItemData<T: Encodable>(_ object: T) -> Data? {
        do {
            let data = try PropertyListEncoder().encode(object)
            return data
        } catch {
            self.isError = true
            self.errorMessage = error.localizedDescription
            return nil
        }
        
    }
    
    private func decodeItemData<T: Decodable>(_ type: T.Type, from data: Data) -> T? {
        do {
            let object = try PropertyListDecoder().decode(type, from: data)
            return object
        } catch {
            self.isError = true
            self.errorMessage = error.localizedDescription
            return nil
        }
    }
    
    private func receivedDataFrommWatch(_ data: [String: Any]) {
        let itemData: Data = data[itemDataKey] as! Data
        let item = decodeItemData(ToDoItem.self, from: itemData)
        DispatchQueue.main.async { [weak self] in
            self?.item = item
            
        }
    }
    
}

extension WatchConnectivityManager: WCSessionDelegate {
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        receivedDataFrommWatch(message)
    }
    
    func session(_ session: WCSession,
                 activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?) {}
    
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
    #endif
}
