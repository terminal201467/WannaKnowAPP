//
//  CommentsDataBase.swift
//  想知道嗎論壇APP
//
//  Created by Jhen Mu on 2022/3/4.
//

import Foundation

class CommentsDataBase{
    //MARK:-Properties
    
    private var commentData:[CommentsData] = []{
        didSet{
            valueChange?()
        }
    }
    
    var valueChange:(()->Void)?
    
    var onError:((Error)->Void)?
    
    //MARK:-LoadDate and Post
    public func loadData(byID id:String){
        CommentsAPI.shared.getCommentsAPI(callBy: .wanna_know_id(id)) { result in
            switch result{
            case .success(let data):  self.commentData = data
                //Post上去的資料Get不下來，我覺得應該是資料沒有Post上去
                print("資料：",self.commentData)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    public func postComments(byID id:String, comments content:String){
        let data = PostComments(wanna_know_id: id, content: content)
        CommentsAPI.shared.postCommentAPI(encodeData: .postComments(data)) { result in
            switch result{
            case .success(let data):
                print(data)
                print("資料傳送狀態：",data.message)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    public func postLike(byID id:String, like:Bool){
        let data = PostLike(comment_id: id, like: like)
        CommentsAPI.shared.postCommentAPI(encodeData: .postLike(data)) { result in
            switch result{
            case .success(let data):  print("資料傳送狀態：",data.message)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    public func numberOfRowsInSection(_ section:Int)->Int{
        return commentData.count
    }
    
    public func getData(_ indexPath:IndexPath)->CommentsData{
        return commentData[indexPath.row]
    }
    
    public func appendData(_ data:CommentsData){
        commentData.append(data)
    }
    
    public func removeAll(){
        return commentData.removeAll()
    }
}
