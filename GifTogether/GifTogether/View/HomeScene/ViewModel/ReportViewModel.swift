//
//  ReportViewModel.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/05/07.
//

import Foundation

final class ReportViewModel: ObservableObject {
    private let createReportUseCase: CreateReportUseCase
    
    init(
        createReportUseCase: CreateReportUseCase
    ) {
        self.createReportUseCase = createReportUseCase
    }
    
    func request(report: Report) {
        createReportUseCase.execute(report: report)
    }
}
