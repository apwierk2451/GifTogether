//
//  CreateReportUseCase.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/05/07.
//

protocol CreateReportUseCase {
    func execute(report: Report)
}

struct DefaultCreateReportUseCase: CreateReportUseCase {
    private let reportRepository: ReportRepository
    
    init(reportRepository: ReportRepository) {
        self.reportRepository = reportRepository
    }
    
    func execute(report: Report) {
        reportRepository.create(report)
    }
}

