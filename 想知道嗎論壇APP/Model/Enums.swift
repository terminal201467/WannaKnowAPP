//
//  Model.swift
//  想知道嗎論壇APP
//
//  Created by Jhen Mu on 2022/1/19.
//

import Foundation

enum SideMenuName:Int,CaseIterable{
    case xiangZhiDaoMa = 1
    var title:String{
        switch self {
        case .xiangZhiDaoMa: return "想知道嗎"
        }
    }
    var logoName:String{
        switch self {
        case .xiangZhiDaoMa: return "brain"
        }
    }
}

enum MenuPageName:Int,CaseIterable{
    case bulletin = 0,xiangZhiDao,chaoWuan
    var title:String{
        switch self {
        case .bulletin:    return "公告欄"
        case .xiangZhiDao: return "想知道嗎"
        case .chaoWuan:    return "敲碗想知道"
        }
    }
}

enum SegmentedTitle:Int,CaseIterable{
    case article = 0,calender
    var title:String{
        switch self {
        case .article:  return "文章"
        case .calender: return "日曆"
        }
    }
}

enum CellLogo:Int,CaseIterable{
    case like = 0,collection,message,personLogo,link
    var logo:String{
        switch self {
        case .like:          return "hand.thumbsup"
        case .collection:    return "collection"
        case .message:       return "message"
        case .personLogo:    return "person"
        case .link:          return "link"
        }
    }
    
}

enum ArticlePages:Int,CaseIterable{
    case news = 0,hot,follow
    var text:String{
        switch self {
        case .news:   return "最新"
        case .hot:    return "熱門"
        case .follow: return "追蹤"
        }
    }
    var parameter:String{
        switch self {
        case .news:   return "new"
        case .hot:    return "hot"
        case .follow: return "follow"
        }
    }
}

enum ArticleKind:Int,CaseIterable{
    case all = 0,projectExp,learnMemo,skillResearch,workLife,lifeChannel
    var text:String{
        switch self {
        case .all:           return "全部"
        case .projectExp:    return "專案經驗"
        case .learnMemo:     return "學習小心得"
        case .skillResearch: return "技術剖析"
        case .workLife:      return "職場工作"
        case .lifeChannel:   return "生活頻道"
        }
    }
    var parameter:String{
        switch self{
        case .all:           return ""
        case .projectExp:    return "project"
        case .learnMemo:     return "learning"
        case .skillResearch: return "technic"
        case .workLife:      return "career"
        case .lifeChannel:   return "life"
        }
    }
}

enum InternetError:Error{
    case invalidURL
    case requestFailed
    case invalidData
    case invalidResponse
}


enum PostEncodeBody:Encodable{
    case postComments(PostComments)
    case postLike(PostLike)
}
