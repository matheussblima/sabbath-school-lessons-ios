//
//  LessonViewModel.swift
//  Escola Sabatina
//
//  Created by Matheus  Lima  on 13/07/23.
//

import Foundation

protocol LessonViewModelDelegate: AnyObject {
    func didGetLessons(_ lessons: [Lesson]?, error: DataError?)
}

class LessonViewModel: MulticastDelegate<LessonViewModelDelegate> {
    let lessonsService = LessonsService()
    var lessons: [Lesson]?
   
    func getLanguages(idQuartely: String, languageCode: String) {
        lessonsService.getLessons(idQuartely: idQuartely, languageCode: languageCode) { [self] result in
            switch result {
            case .success(let lessons):
                self.lessons = lessons
                invokeForEachDelegate { $0.didGetLessons(lessons, error: nil) }
            case .failure(let error):
                invokeForEachDelegate { $0.didGetLessons(nil, error: .netWorkingError(error.localizedDescription)) }
            }
        }
    }
}
