//
//  NotesModel.swift
//  Basic_Note_App
//
//  Created by xmod on 8.08.2022.
//

import Foundation

// MARK: - Welcome
struct NotesModel: Codable {
    let code: String
    let data: NoteData
    let message: String
}

// MARK: - DataClass
struct NoteData: Codable {
    let currentPage: Int
    let data: [Datum]
    let firstPageURL: String
    let from, lastPage: Int
    let lastPageURL: String
    let links: [Link]
    let nextPageURL: JSONNull?
    let path: String
    let perPage: Int
    let prevPageURL: JSONNull?
    let to, total: Int

    // Enum ile seri name verdik
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case links
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let title, note: String
}

// MARK: - Link
struct Link: Codable {
    let url: String?
    let label: String
    let active: Bool
}

// MARK: - Encode/decode helpers
class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

