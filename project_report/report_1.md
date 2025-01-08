# Tên đề tài: Nghiên cứu về DevOps và xây dựng hệ thống CI/CD cho dự án thực tế

## Lời cảm ơn

Trong quá trình học tập, nghiên cứu và thực hiện đồ án, em đã nhận được sự giúp đỡ, góp ý và chỉ bảo nhiệt tình từ thầy cô, gia đình và bạn bè. Em xin bày tỏ lòng biết ơn sâu sắc và chân thành nhất.

Trước hết, em xin gửi lời cảm ơn đến thầy Đặng Ngọc Hùng, người đã tận tình hướng dẫn, chỉ bảo và truyền đạt kiến thức cũng như kinh nghiệm quý báu cho em trong suốt quá trình thực hiện đồ án.

Em cũng xin chân thành cảm ơn quý thầy cô trong trường, đặc biệt là các thầy cô trong Khoa Công nghệ thông tin, đã truyền đạt cho em những kiến thức về các môn đại cương và chuyên ngành, giúp em có nền tảng lý thuyết vững chắc và tạo điều kiện thuận lợi cho em trong suốt quá trình học tập.

Cuối cùng, em xin gửi lời cảm ơn đến gia đình và bạn bè đã luôn động viên, quan tâm và hỗ trợ em trong suốt quá trình học tập và thực hiện đồ án tốt nghiệp này.

Em xin chân thành cảm ơn!

## Mục lục

[Danh Sách Các Hình Ảnh](#danh-sách-các-hình-ảnh)

[Danh Mục Thuật Ngữ Và Các Từ Viết Tắt](#danh-mục-thuật-ngữ-và-các-từ-viết-tắt)

[Lời Nói Đầu](#lời-nói-đầu)

1. [Chương 1: Tổng quan về DevOps và CI/CD](#chương-1-tổng-quan-về-devops-và-cicd)
   - [1.1. DevOps là gì? Và lý do cần DevOps?](#11-devops-là-gì-và-lý-do-cần-devops)
   - [1.2. Sự hình thành và phát triển của DevOps](#12-sự-hình-thành-và-phát-triển-của-devops)
   - [1.3. Vai Trò của DevOps trong Từng Giai Đoạn Phát Triển Phần Mềm](#13-vai-trò-của-devops-trong-từng-giai-đoạn-phát-triển-phần-mềm)
   - [1.4. Khái niệm, vai trò và các nguyên tắc cơ bản của CI/CD trong DevOps](#14-khái-niệm-vai-trò-và-các-nguyên-tắc-cơ-bản-của-cicd-trong-devops)
   - [1.5. Lợi ích của việc áp dụng CI/CD](#15-lợi-ích-của-việc-áp-dụng-cicd)
   - [1.6. Pipeline trong CI/CD](#16-pipeline-trong-cicd)
   - [1.7. GitOps](#17-gitops)
   - [1.8. Branching Strategy](#18-branching-strategy)
2. [Chương 2: Công cụ và hệ sinh thái trong CI/CD](#chương-2-công-cụ-và-hệ-sinh-thái-trong-cicd)
   - [2.1. Tổng quan các công cụ CI/CD phổ biến](#21-tổng-quan-các-công-cụ-cicd-phổ-biến)
   - [2.2. Hệ sinh thái CI/CD](#22-hệ-sinh-thái-cicd)
   - [2.3. Các công cụ được sử dụng trong CI/CD cho dự án Ecommerce](#23-các-công-cụ-được-sử-dụng-trong-cicd-cho-dự-án-ecommerce)
3. [Chương 3: Xây dựng hệ thống CI/CD cho dự án Ecommerce](#chương-3-xây-dựng-hệ-thống-cicd-cho-dự-án-ecommerce)
   - [3.1. Cấu hình hệ thống CI/CD](#31-cấu-hình-hệ-thống-cicd)
   - [3.2. Kiến trúc hệ thống](#32-kiến-trúc-hệ-thống)
   - [3.3. Xây dựng chiến lược branching trong CI/CD](#33-xây-dựng-chiến-lược-branching-trong-cicd)
   - [3.4. Tích hợp CI/CD cho dự án Ecommerce](#34-tích-hợp-cicd-cho-dự-án-ecommerce)
   - [3.5. Quy trình Go-Live lên môi trường sản xuất](#35-quy-trình-go-live-lên-môi-trường-sản-xuất)
   - [3.6. Kịch bản vận hành hệ thống CI/CD](#36-kịch-bản-vận-hành-hệ-thống-cicd)
4. [Chương 4: Kết luận](#chương-4-kết-luận)