## Chương 1: Tổng quan về DevOps và CI/CD

### 1.1. DevOps là gì? Và lý do cần DevOps?

Thông thường vòng đời của một sản phẩm phần mềm (Software Development Life Cycle - SDLC) gồm 2 giai đoạn chính: giai đoạn phát triển và giai đoạn vận hành. Giai đoạn phát triển bao gồm phần việc của Business Analyst (BA), UI/UX Designer, Developer, QA/QC Engineer với các công việc như requirement analysis, system design, implementation và testing. Giai đoạn vận hành có sự tham gia của System Engineer, System Administrator (SysAdmin), Operation Executive, Release Engineer, Database Administrator (DBA), Network Engineer, Security Engineer, Site Reliability Engineer (SRE) với các nhiệm vụ như infrastructure management, monitoring, incident response và capacity planning. Ở mỗi giai đoạn đều có những đội nhóm và công việc tách biệt. Sự tách biệt này càng phân hóa rõ ràng ở những công ty có quy mô từ trung bình trở lên. Mục tiêu của nhóm phát triển là phát triển các tính năng mới liên quan đến những thay đổi đối với môi trường hiện có, đảm bảo các SLA (Service Level Agreement) và KPI (Key Performance Indicators). Điều đó có nghĩa là những thay đổi mới được đưa vào một môi trường mà trên thực tế một môi trường có tính ổn định có thể bị mất ổn định do những thay đổi được đưa ra, ảnh hưởng đến các metrics như availability, reliability và performance, điều này mâu thuẫn trực tiếp với mục tiêu của các nhóm vận hành. Sự mâu thuẫn này hình thành nên khái niệm Wall of confusion - Bức tường của sự hiểu lầm. Nó sẽ là rào cản kìm hãm sự phát triển phần mềm khiến cho nỗ lực làm việc của nhân viên cũng như chất lượng phần mềm ngày càng giảm sút.

Về mặt sản phẩm, với sự phát triển của công nghệ kéo theo sự bùng nổ về quy mô của các công ty cũng như sự đa dạng các sản phẩm công nghệ khiến cho quy mô của các hệ thống cũng mở rộng theo cấp số nhân. Từ một vài server, hệ thống có thể phát triển lên đến hàng chục, hàng trăm, hàng nghìn, hoặc thậm chí hàng triệu server (ví dụ như trường hợp của Google, Facebook) với các công nghệ như cloud computing, containerization và orchestration. Đồng thời ngành phát triển phần mềm cũng dịch chuyển theo một hướng khác – microservices architecture - một sản phẩm lớn được chia tách ra thành rất nhiều các service nhỏ, các service này liên kết với nhau thông qua APIs và message queues, được quản lý bởi service mesh và load balancers, tạo thành một sản phẩm hoàn chỉnh. Trước nhu cầu phát triển và cải tiến sản phẩm liên tục, những thách thức mới, những bài toán mới được đặt ra:

- Về mặt quy trình, hay là khía cạnh con người, làm thế nào để các bộ phận hợp tác thuận lợi hơn thông qua các practices như agile methodology, scrum framework và kanban? Làm thế nào để quy trình làm việc được trơn tru, suôn sẻ hơn với incident management, change management và release management?
- Về mặt sản phẩm, làm thế nào để các service kết nối và giao tiếp với nhau theo những nguyên tắc hiệu quả như service discovery, circuit breaker và retry patterns, cũng như đảm bảo việc mở rộng quy mô được dễ dàng và êm ái hơn thông qua auto-scaling và distributed systems?

Khái niệm DevOps ra đời nhằm giải quyết những vấn đề này. DevOps giúp tối ưu hóa chu trình phát triển phần mềm, giúp sản phẩm phần mềm được cập nhật, phát hành nhanh và thường xuyên hơn thông qua các practices như Infrastructure as Code (IaC), Configuration as Code (CaC), và Policy as Code (PaC).

Vậy **DevOps** là gì?

DevOps là một phương pháp phát triển phần mềm kết hợp giữa phát triển (Development) và vận hành (Operations). Mục tiêu của DevOps là cải thiện sự hợp tác và giao tiếp giữa các nhóm phát triển và vận hành, từ đó tăng tốc độ phát triển phần mềm, nâng cao chất lượng sản phẩm và giảm thiểu rủi ro trong quá trình triển khai.

DevOps không chỉ là một tập hợp các công cụ và quy trình, mà còn là một văn hóa làm việc mới, nơi mà các nhóm phát triển và vận hành cùng chia sẻ trách nhiệm và hợp tác chặt chẽ để đạt được mục tiêu chung. DevOps thúc đẩy việc tự động hóa các quy trình phát triển, kiểm thử và triển khai, giúp giảm thiểu các công việc thủ công và tăng cường hiệu quả làm việc.

Một số nguyên tắc cơ bản của DevOps bao gồm:

1. **Tự động hóa**: Tự động hóa các quy trình phát triển, kiểm thử và triển khai để giảm thiểu sai sót do con người và tăng tốc độ phát hành phần mềm.
2. **Liên tục cải tiến**: Luôn tìm kiếm các cơ hội để cải tiến quy trình và công nghệ, từ đó nâng cao chất lượng sản phẩm và hiệu quả làm việc.
3. **Hợp tác chặt chẽ**: Tăng cường sự hợp tác và giao tiếp giữa các nhóm phát triển và vận hành, giúp giảm thiểu xung đột và tăng cường hiệu quả làm việc.
4. **Phản hồi nhanh chóng**: Thu thập và phản hồi nhanh chóng các thông tin từ người dùng và hệ thống, từ đó cải tiến sản phẩm và quy trình một cách liên tục.
5. **Bảo mật tích hợp**: Tích hợp các biện pháp bảo mật vào toàn bộ vòng đời phát triển phần mềm, giúp đảm bảo an toàn và tuân thủ các quy định.

**DevOps** đã trở thành một yếu tố quan trọng trong việc phát triển phần mềm hiện đại, giúp các tổ chức tối ưu hóa quy trình phát triển, nâng cao chất lượng sản phẩm và đáp ứng nhanh chóng với nhu cầu của thị trường.

Lợi ích của **DevOps** nằm ở khả năng cải tiến và chuyển đổi quy trình phát triển và vận hành phần mềm từ mô hình truyền thống Waterfall (thác nước) sang mô hình CI/CD (phát triển liên tục) [1] [2]. Bên cạnh đó, **DevOps** còn mang lại một số lợi ích đáng kể khác như sau:

- Tốc độ: DevOps cho phép hoạt động với tốc độ nhanh và tần suất cao, từ đó cải thiện khả năng phục vụ khách hàng, linh hoạt thích nghi với sự thay đổi liên tục của thị trường và đạt được hiệu quả kinh doanh đáng kể. DevOps đóng vai trò là công cụ hỗ trợ cho các nhà phát triển và nhóm nghiệp vụ trong việc đạt được những mục tiêu này.
- Chuyển giao nhanh chóng: Tăng tần suất và nhịp độ phát hành là yếu tố cần thiết để cải thiện và nâng cấp sản phẩm một cách nhanh chóng. Việc phát hành các tính năng mới giúp khắc phục sự cố kỹ thuật nhanh hơn, đáp ứng nhu cầu khách hàng và tạo lợi thế cạnh tranh. Độ tin cậy: Mặc dù tốc độ chuyển giao được đẩy nhanh, DevOps vẫn đảm bảo độ tin cậy và chất lượng của sản phẩm cũng như trải nghiệm người dùng cuối thông qua việc áp dụng CI/CD, giám sát và ghi nhật ký.
- Khả năng mở rộng: Nhờ vào tự động hóa và tính nhất quán, DevOps giúp quản lý hiệu quả các hệ thống phức tạp hoặc thường xuyên thay đổi với mức rủi ro thấp nhất.
- Cải thiện khả năng cộng tác: DevOps xây dựng các nhóm làm việc hiệu quả hơn bằng cách nhấn mạnh vào giá trị của sự tự chủ và trách nhiệm đối với công việc. Các nhà phát triển và nhóm nghiệp vụ hợp tác chặt chẽ, chia sẻ trách nhiệm và phối hợp thực hiện các quy trình công việc, từ đó giảm thiểu sự chậm trễ và tiết kiệm thời gian.
- Bảo mật: DevOps tăng tốc quá trình mà không ảnh hưởng đến tính bảo mật nhờ vào các chính sách tuân thủ tự động hóa, công cụ kiểm soát và kỹ thuật quản lý.

### 1.2. Sự hình thành và phát triển của DevOps

Các đề xuất kết hợp các phương pháp phát triển phần mềm với các khái niệm triển khai và vận hành đã bắt đầu xuất hiện vào cuối những năm 1980 và đầu những năm 1990. Trong giai đoạn này, các tổ chức đã nhận ra rằng việc phát triển phần mềm và triển khai vận hành thường được thực hiện bởi các nhóm riêng biệt, dẫn đến sự thiếu hiệu quả và nhiều vấn đề trong việc phối hợp. Đến khoảng năm 2007 và 2008, các cộng đồng phát triển phần mềm và công nghệ thông tin đã bắt đầu bày tỏ mối lo ngại về sự tách biệt này. Họ nhận thấy rằng việc một bên chỉ tập trung vào việc viết và tạo ra phần mềm mà không có sự liên kết chặt chẽ với những người chịu trách nhiệm triển khai và hỗ trợ phần mềm đã tạo ra một mức độ rối loạn chức năng nghiêm trọng trong ngành công nghiệp phần mềm.

Năm 2009, hội nghị đầu tiên mang tên DevOps Days được tổ chức tại Ghent, Bỉ. Hội nghị này được sáng lập bởi Patrick Debois, một nhà tư vấn người Bỉ, người đã có nhiều kinh nghiệm trong quản lý dự án và thực hành Agile. Hội nghị DevOps Days đã nhanh chóng lan rộng ra các quốc gia khác, trở thành một diễn đàn quan trọng để các chuyên gia chia sẻ kinh nghiệm và thảo luận về các phương pháp tốt nhất trong việc kết hợp phát triển và vận hành phần mềm.

Năm 2012, một báo cáo có tên "State of DevOps" lần đầu tiên được xuất bản bởi Alanna Brown tại Puppet Labs. Báo cáo này đã cung cấp một cái nhìn sâu sắc về tình trạng và xu hướng của DevOps trong ngành công nghiệp phần mềm. Từ năm 2014, báo cáo thường niên State of DevOps được xuất bản bởi Nicole Forsgren, Gene Kim, Jez Humble và những người khác, đã chỉ ra rằng việc áp dụng DevOps đang gia tăng nhanh chóng. Cũng trong năm 2014, Lisa Crispin và Janet Gregory đã viết cuốn sách "More Agile Testing", trong đó có một chương đặc biệt về kiểm thử và DevOps, nhấn mạnh tầm quan trọng của việc tích hợp kiểm thử vào quy trình DevOps.

Năm 2016, các chỉ số DORA (DevOps Research and Assessment) về thông lượng và độ ổn định đã được công bố trong báo cáo State of DevOps. Các chỉ số này bao gồm tần suất triển khai, thời gian dẫn cho các thay đổi, thời gian trung bình để phục hồi và tỷ lệ thất bại thay đổi. Tuy nhiên, phương pháp nghiên cứu và các chỉ số này đã bị chỉ trích bởi một số chuyên gia trong ngành. Để đáp lại những chỉ trích này, báo cáo State of DevOps năm 2023 đã công bố những thay đổi cập nhật, đặc biệt là việc điều chỉnh chỉ số độ ổn định từ "thời gian trung bình để phục hồi" thành "thời gian phục hồi triển khai thất bại", nhằm thừa nhận và giải quyết sự nhầm lẫn mà chỉ số trước đó đã gây ra.

Sự hội tụ của các phong trào quản lý và công nghệ này đã tạo nên nền tảng vững chắc cho sự hình thành và phát triển của DevOps. DevOps không chỉ là một tập hợp các công cụ và quy trình, mà còn là một triết lý và văn hóa làm việc mới, nơi mà sự hợp tác và tự động hóa được đặt lên hàng đầu để tối ưu hóa quy trình phát triển phần mềm.

### 1.3. Vai Trò của DevOps trong Từng Giai Đoạn Phát Triển Phần Mềm

DevOps đóng vai trò quan trọng và không thể thiếu trong từng giai đoạn của vòng đời phát triển phần mềm, bao gồm: Lên Kế Hoạch, Lập Trình, Xây Dựng, Kiểm Thử, Phát Hành, Triển Khai, Vận Hành, và Giám Sát. Mỗi giai đoạn đều có những yêu cầu và thách thức riêng, và DevOps Engineer là người đảm bảo rằng các quy trình và công cụ được tích hợp một cách hiệu quả để tối ưu hóa sự phát triển và vận hành phần mềm.

Trong giai đoạn Lên Kế Hoạch, DevOps Engineer tham gia vào việc xác định kiến trúc ứng dụng và các yêu cầu cơ sở hạ tầng. Họ cần phân tích và xác định các thành phần phần mềm cần thiết, luồng hoạt động của hệ thống, và các yêu cầu cơ sở hạ tầng cần thiết để hỗ trợ ứng dụng. Điều này đòi hỏi một sự hiểu biết sâu sắc về cách các thành phần phần mềm tương tác với nhau và cách chúng sẽ được triển khai trên cơ sở hạ tầng hiện có. DevOps Engineer cũng cần xác định các phụ thuộc, tức là các công nghệ và công cụ cần thiết để phát triển và duy trì hạ tầng. Điều này bao gồm việc đánh giá khả năng duy trì và mở rộng của các công nghệ hiện tại, cũng như khả năng tích hợp với các công nghệ mới. Họ cũng cần đánh giá kích thước của dự án, tức là xác định tài nguyên cần thiết để quản trị hạ tầng một cách hợp lý và hiệu quả, đảm bảo rằng hệ thống có thể đáp ứng được nhu cầu hiện tại và tương lai. Ngoài ra, DevOps Engineer cũng thiết lập các nguyên tắc và hướng dẫn chi tiết cho đội ngũ phát triển. Điều này bao gồm việc tổ chức nhánh git một cách khoa học và phân chia môi trường cho hệ thống CI, đảm bảo rằng các thay đổi mã nguồn được quản lý và tích hợp một cách hiệu quả. Họ cũng cần định vị và cấu hình ứng dụng một cách chính xác, đảm bảo rằng các cấu hình này phù hợp với môi trường triển khai.

Trong giai đoạn Lập Trình, DevOps Engineer không chỉ hỗ trợ quản lý kho git mà còn tham gia vào việc đánh giá mã nguồn, đảm bảo rằng mã nguồn được viết theo các tiêu chu��n và thực hành tốt nhất, giúp giảm thiểu lỗi và cải thiện chất lượng phần mềm. Họ cũng có thể tham gia vào việc thiết lập các công cụ kiểm thử tự động, giúp phát hiện sớm các lỗi và vấn đề bảo mật trong mã nguồn.

Giai đoạn Xây Dựng là một phần quan trọng trong quy trình DevOps, nơi DevOps Engineer tập trung vào việc sử dụng các công cụ như Docker để đóng gói ứng dụng dưới dạng container. Việc này không chỉ giúp chuẩn hóa môi trường triển khai mà còn hỗ trợ tự động hóa quy trình CI với các công cụ như GitLab CI, Jenkins, Circle CI. Tối ưu hóa Dockerfile là một nhiệm vụ quan trọng, có thể giúp giảm thời gian xây dựng, giảm kích thước image, và tăng cường bảo mật cho ứng dụng. DevOps Engineer cũng cần đảm bảo rằng các bản build được thực hiện một cách nhất quán và có thể tái tạo, giúp giảm thiểu rủi ro khi triển khai.

Trong giai đoạn Kiểm Thử, DevOps Engineer có thể tham gia vào việc viết các test case đơn giản và chuẩn bị môi trường kiểm thử, đảm bảo rằng các tính năng mới được kiểm thử đầy đủ trước khi triển khai. Họ cũng có thể thiết lập các công cụ kiểm thử tự động để đảm bảo rằng các bài kiểm thử được thực hiện một cách nhất quán và hiệu quả.

Giai đoạn Phát Hành là khi phần mềm được chuyển giao từ đội ngũ phát triển sang vận hành. DevOps Engineer cần yêu cầu viết Release note chi tiết để theo dõi các thay đổi và đánh giá rủi ro, cũng như lập kế hoạch migrate và rollback nếu cần thiết, đảm bảo rằng quá trình phát hành diễn ra suôn sẻ và không gây ra gián đoạn cho người dùng. Họ cũng cần đảm bảo rằng các bản phát hành được thực hiện một cách nhất quán và có thể tái tạo, giúp giảm thiểu rủi ro khi triển khai.

Giai đoạn Triển Khai liên quan đến việc chuẩn bị môi trường và tự động hóa quy trình triển khai qua hệ thống CD, đảm bảo rằng phần mềm được triển khai một cách nhất quán và đáng tin cậy. DevOps Engineer cần đảm bảo rằng các bản triển khai được thực hiện một cách nhất quán và có thể tái tạo, giúp giảm thiểu rủi ro khi triển khai.

Trong giai đoạn Vận Hành, DevOps Engineer cung cấp các công cụ và hệ thống để phát hiện và sửa lỗi nhanh chóng. Điều này bao gồm việc thiết lập hệ thống log tập trung để thu thập và phân tích dữ liệu log, giám sát tài nguyên để đảm bảo rằng hệ thống hoạt động hiệu quả, và sử dụng bảng điều khiển CI/CD để theo dõi và quản lý các quy trình triển khai. Họ cũng cần tích hợp các công cụ truy vết lỗi và hệ thống thông báo sự cố để nhanh chóng phát hiện và khắc phục các vấn đề, đảm bảo rằng hệ thống luôn hoạt động ổn định và đáp ứng được nhu cầu của người dùng.

Cuối cùng, giai đoạn Giám Sát yêu cầu DevOps Engineer và đội ngũ quản trị giám sát toàn bộ hệ thống, lập kế hoạch mở rộng, đánh giá rủi ro, và triển khai hệ thống giám sát/cảnh báo khi có sự cố. DevOps Engineer cần đảm bảo rằng hệ thống giám sát được thiết lập một cách nhất quán và có thể tái tạo, giúp giảm thiểu rủi ro khi triển khai.

### DevSecOps

#### DevSecOps là gì?

DevSecOps là một phương pháp phát triển phần mềm kết hợp ba yếu tố chính: phát triển (Development), vận hành (Operations) và bảo mật (Security). Mục tiêu của DevSecOps là tích hợp bảo mật vào toàn bộ vòng đời phát triển phần mềm, từ giai đoạn thiết kế cho đến triển khai và bảo trì. Điều này có nghĩa là bảo mật không chỉ được xem xét ở giai đoạn cuối mà phải được tích hợp ngay từ đầu, giúp nhận diện và khắc phục các lỗ hổng bảo mật một cách sớm nhất.

#### Lợi ích của DevSecOps

1. **Tích hợp Bảo mật Sớm**: DevSecOps cho phép phát hiện và xử lý các vấn đề bảo mật ngay từ giai đoạn đầu của phát triển, từ đó giảm thiểu rủi ro khi triển khai.

2. **Tăng cường Hiệu suất**: Sự hợp tác chặt chẽ giữa các nhóm phát triển, vận hành và bảo mật giúp tăng tốc độ phát triển và giảm thời gian phát hành sản phẩm.

3. **Giảm Chi phí**: Việc phát hiện sớm các lỗ hổng bảo mật giúp tiết kiệm chi phí khắc phục sau này, tránh việc phải xử lý các vấn đề nghiêm trọng sau khi sản phẩm đã được phát hành.

4. **Cải thiện Độ Tin cậy**: Khi bảo mật được tích hợp vào quy trình phát triển, sản phẩm cuối cùng sẽ đáng tin cậy hơn và có độ an toàn cao hơn.

5. **Nâng cao Nhận thức Bảo mật**: DevSecOps khuyến khích đội ngũ phát triển và vận hành nâng cao nhận thức về bảo mật, từ đó góp phần xây dựng văn hóa bảo mật trong tổ chức.

### 1.4. Khái niệm, vai trò và các nguyên tắc cơ bản của CI/CD trong DevOps

Ở phần trước chúng ta đã tìm hiểu về DevOps và có đề cập tới CI/CD. DevOps ra đời mang theo một mô hình phát triển phần mềm mới đó là hệ thống tự động hóa CI/CD. Có thể nói CI/CD chính là trái tim của DevOps. Trong chương này ta sẽ tìm hiểu hệ thống CI/CD là gì? CI/CD pipeline là gì? Cách thức triển khai một hệ thống CI/CD hoàn chỉnh.

#### Khái niệm CI/CD

CI (Continuous Integration) - Tích hợp liên tục, là quá trình tự động hóa việc tích hợp mã nguồn từ các thành viên trong nhóm phát triển vào một kho lưu trữ mã nguồn (như Git) một cách sớm và thường xuyên. Mỗi khi có thay đổi về mã nguồn, mã sẽ được tự động kiểm thử thông qua các quy tỉtrình xác thực. Thông thường, quy trình bắt đầu bằng việc phân tích mã tĩnh để xác minh chất lượng mã. Sau khi mã vượt qua các bài kiểm thử tĩnh, quy trình CI tự động sẽ đóng gói và biên dịch mã để kiểm thử động. Quy trình CI cần có hệ thống kiểm soát phiên bản để theo dõi các thay đổi và biết phiên bản mã được sử dụng.
Mục tiêu của CI là đảm bảo rằng mã nguồn mới được thêm vào dự án không gây ra lỗi tích hợp và không ảnh hưởng đến công việc của các thành viên khác. Với tích hợp liên tục, các lỗi và vấn đề bảo mật có thể được phát hiện và sửa chữa dễ dàng và sớm hơn trong quá trình phát triển.

Bằng cách hợp nhất các thay đổi thường xuyên và kích hoạt các quy trình kiểm thử và xác thực tự động, hệ thống CI giúp giảm thiểu khả năng xung đột mã, ngay cả khi có nhiều nhà phát triển làm việc trên cùng một ứng dụng. Một lợi ích lớn của hệ thống CI là rút ngắn thời gian chờ từ khi các nhà phát triển commit mã cho đến khi nhận được phản hồi đánh giá chất lượng mã nguồn từ các bộ phận khác và tiến hành thay đổi, sửa lỗi. Với CI, các nhà phát triển không phải đợi lâu để có kết quả đánh giá chất lượng mã nguồn, từ đó có thể sẵn sàng sửa các lỗi và vấn đề bảo mật sớm nhất có thể.
CD (Continuous Delivery/Continuous Deployment), thuật ngữ CD có hai nghĩa là Phân phối liên tục và Triển khai liên tục.
Phân phối liên tục đề cập đến việc tự động hóa quy trình cung cấp cơ sở hạ tầng và phát hành ứng dụng. Sau khi mã đã được kiểm thử và xây dựng, hệ thống Phân phối liên tục sẽ tiếp quản các giai đoạn cuối cùng để đảm bảo mã được đóng gói với mọi thứ cần thiết để triển khai trên mọi môi trường vào bất kỳ lúc nào. Phân phối liên tục có thể bao gồm mọi công đoạn từ việc cung cấp cơ sở hạ tầng đến việc phân phối ứng dụng tới các môi trường thử nghiệm hoặc sản xuất. Với Phân phối liên tục, phần mềm được xây dựng có thể triển khai vào môi trường sản xuất bất kỳ lúc nào. Việc triển khai có thể kích hoạt theo cách thủ công hoặc chuyển sang Triển khai liên tục, trong đó việc triển khai cũng được tự động hóa.

Triển khai liên tục là giai đoạn cuối của quá trình CI/CD. Triển khai liên tục là phần mở rộng của Phân phối liên tục, cho phép các tổ chức triển khai ứng dụng của họ một cách tự động, loại bỏ nhu cầu can thiệp của con người. Với việc triển khai liên tục, các nhóm DevOps đặt ra trước các tiêu chí cho việc phát hành mã và khi các tiêu chí đó được đáp ứng và xác thực, mã sẽ được triển khai vào môi trường sản xuất. Điều này cho phép các tổ chức hoạt động linh hoạt hơn và đưa các tính năng mới đến người dùng nhanh hơn.

Mặc dù có thể thực hiện CI mà không cần CD, nhưng thực sự không thể thực hiện CD nếu không có sẵn CI. Đó là bởi vì sẽ cực kỳ khó để có thể triển khai vào môi trường sản xuất bất cứ lúc nào nếu không thực hành các nguyên tắc cơ bản về CI như tích hợp mã vào kho lưu trữ chung, tự động hóa kiểm thử và xây dựng cũng như thực hiện tất cả các công việc đó theo từng đợt nhỏ hàng ngày. Thực tế, việc Triển khai liên tục sẽ không được khuyến khích áp dụng với môi trường sản xuất mà chỉ áp dụng với các môi trường phát triển, kiểm thử, UAT, staging, v.v... bởi môi trường sản xuất là quan trọng nhất, bước cuối cùng triển khai cần phải thực hiện thủ công, yêu cầu sự đánh giá và chấp thuận của cá nhân/tổ chức có thẩm quyền.

Với CI/CD, mỗi thay đổi mã nguồn của nhà phát triển đều có thể xuất hiện trên ứng dụng trong vài phút hoặc vài giờ (trong trường hợp mã nguồn vượt qua quá trình kiểm thử tự động). Điều này giúp việc liên tục nhận phản hồi dễ dàng hơn nhiều, từ đó việc thay đổi, sửa đổi, sửa lỗi diễn ra thường xuyên hơn. Kết hợp lại với nhau, tất cả các phương pháp CI/CD được kết nối này giúp việc triển khai ứng dụng ít rủi ro hơn, nhờ đó việc phát hành các thay đổi đối với ứng dụng theo từng phần nhỏ sẽ dễ dàng hơn thay vì tất cả cùng một lúc. Tuy nhiên, cũng cần phải đầu tư trước rất nhiều nỗ lực vì hệ thống tự động cần được xây dựng một cách phù hợp và đảm bảo vận hành trơn tru trong từng giai đoạn, từng trường hợp trong quy trình CI/CD.

#### Vai trò và nguyên tắc của CI/CD trong DevOps

### Tích hợp thường xuyên (Frequent Integration)

Các nhà phát triển nên tích hợp mã của họ vào version control system một cách thường xuyên thông qua các practices như trunk-based development hoặc feature branching, lý tưởng là nhiều lần trong một ngày. Việc tích hợp thường xuyên giúp phát hiện và giải quyết các merge conflicts ngay từ sớm, giảm thiểu rủi ro và đảm bảo rằng codebase luôn ở trạng thái deployable.

### Kiểm thử tự động (Automated Testing)

Kiểm thử tự động được thực hiện ở mọi giai đoạn của quy trình CI/CD nhằm đảm bảo code quality và application reliability. Các loại kiểm thử bao gồm unit testing, integration testing, system testing, end-to-end testing và acceptance testing. Để tự động hóa các bài kiểm tra này, các công cụ như Selenium cho UI testing, JUnit cho unit testing, Postman cho API testing và pytest cho Python testing thường được sử dụng kết hợp với các code coverage tools và static code analysis tools.

### Phản hồi liên tục (Continuous Feedback)

Development teams nhận được phản hồi liên tục về code quality thông qua các automated test reports, linting warnings, security scan alerts và performance metrics. Phản hồi nhanh chóng cho phép các developers fix bugs kịp thời và cải thiện code quality một cách hiệu quả thông qua các practices như code review, pair programming và test-driven development (TDD).

### Triển khai thường xuyên (Frequent Deployment)

Mục tiêu của CI/CD là triển khai phần mềm đến production environment một cách thường xuyên thông qua các deployment strategies như blue-green deployment, canary deployment và rolling updates. Việc triển khai thường xuyên giúp mang lại business value cho khách hàng một cách nhanh chóng, giảm thiểu deployment risks và cho phép các tổ chức phản ứng nhanh chóng với market demands.

### Môi trường giống Production (Production-Like Environments)

CI/CD yêu cầu sử dụng các môi trường giống production ở mọi giai đoạn của development pipeline. Điều này đảm bảo rằng phần mềm hoạt động nh�� mong đợi khi được triển khai. Các công nghệ container như Docker và container orchestration platforms như Kubernetes thường được sử dụng để tạo ra các immutable và reproducible environments.

### Cải tiến liên tục (Continuous Improvement)

CI/CD là một iterative process, tập trung vào việc cải thiện liên tục các development workflows. DevOps teams áp dụng các kỹ thuật như retrospectives, root cause analysis và A/B testing để xác định các areas for improvement và implement necessary changes. Các metrics như deployment frequency, lead time for changes, mean time to recovery (MTTR) và change failure rate được sử dụng để đo lường và cải thiện hiệu quả của quy trình.

### 1.5. Lợi ích của việc áp dụng CI/CD

CI/CD mang lại nhiều lợi ích quan trọng cho các tổ chức phát triển phần mềm, bao gồm:

1. **Tăng tốc độ phát triển và triển khai**: CI/CD giúp tự động hóa các quy trình phát triển và triển khai, giảm thiểu thời gian chờ đợi và tăng tốc độ phát hành phần mềm.

2. **Cải thiện chất lượng phần mềm**: Bằng cách thực hiện kiểm thử tự động và liên tục, CI/CD giúp phát hiện và khắc phục lỗi sớm, đảm bảo chất lư���ng phần mềm cao hơn.

3. **Giảm thiểu rủi ro**: CI/CD cho phép triển khai các thay đổi nhỏ và thường xuyên, giảm thiểu rủi ro so với việc triển khai các thay đổi lớn và không thường xuyên.

4. **Tăng cường sự hợp tác**: CI/CD thúc đẩy sự hợp tác giữa các nhóm phát triển, kiểm thử và vận hành, giúp cải thiện hiệu quả làm việc và giảm thiểu xung đột.

5. **Nâng cao khả năng phản ứng**: CI/CD cho phép các tổ chức phản ứng nhanh chóng với các yêu cầu thay đổi từ khách hàng hoặc thị trường, giúp duy trì sự cạnh tranh.

6. **Tối ưu hóa tài nguyên**: CI/CD giúp tối ưu hóa việc sử dụng tài nguyên bằng cách tự động hóa các quy trình và giảm thiểu lãng phí.

7. **Tăng cường bảo mật**: CI/CD tích hợp các biện pháp bảo mật vào quy trình phát triển và triển khai, giúp giảm thiểu rủi ro bảo mật và đảm bảo tuân thủ các quy định.

8. **Cải thiện trải nghiệm người dùng**: CI/CD giúp cung cấp các bản cập nhật và tính năng mới một cách nhanh chóng và liên tục, cải thiện trải nghiệm người dùng và tăng cường sự hài lòng của khách hàng.

### 1.6. Pipeline trong CI/CD

Pipeline trong CI/CD là một chuỗi các bước tự động hóa được thực hiện để xây dựng, kiểm thử và triển khai phần mềm. Pipeline giúp đảm bảo rằng mọi thay đổi trong mã nguồn đều được kiểm tra và triển khai một cách nhất quán và đáng tin cậy. Dưới đây là các thành phần chính của một pipeline trong CI/CD:

1. **Source Stage (Giai đoạn nguồn)**:
   - Đây là giai đoạn đầu tiên của pipeline, nơi mã nguồn được lấy từ kho lưu trữ (repository) như GitHub, GitLab, hoặc Bitbucket.
   - Mỗi khi có thay đổi trong mã nguồn (ví dụ: commit mới), pipeline sẽ được kích hoạt để bắt đầu quá trình tự động hóa.

2. **Build Stage (Giai đoạn xây dựng)**:
   - Trong giai đoạn này, mã nguồn được biên dịch và xây dựng thành các gói phần mềm hoặc container.
   - Các công cụ như Maven, Gradle, hoặc Docker thường được sử dụng để thực hiện quá trình này.
   - Giai đoạn này giúp đảm bảo rằng mã nguồn có thể được biên dịch và xây dựng thành công mà không gặp lỗi.

3. **Test Stage (Giai đoạn kiểm thử)**:
   - Giai đoạn kiểm thử bao gồm việc chạy các bài kiểm thử tự động để đảm bảo chất lượng mã.
   - Các loại kiểm thử có thể bao gồm kiểm thử đơn vị (unit tests), kiểm thử tích hợp (integration tests), và kiểm thử hệ thống (system tests).
   - Các công cụ như JUnit, Selenium, và pytest thường được sử dụng để thực hiện các bài kiểm thử này.

4. **Deploy Stage (Giai đoạn triển khai)**:
   - Sau khi mã đã được kiểm thử và xác nhận là không có lỗi, nó sẽ được triển khai đến các môi trường khác nhau như staging, UAT (User Acceptance Testing), và production.
   - Quá trình triển khai có thể bao gồm việc sao chép các tệp tin, cấu hình các dịch vụ, và khởi động lại các ứng dụng.
   - Các công cụ như Ansible, Chef, và Kubernetes thường được sử dụng để tự động hóa quá trình triển khai.

5. **Monitor Stage (Giai đoạn giám sát)**:
   - Giai đoạn giám sát bao gồm việc theo dõi và giám sát các ứng dụng đã triển khai để đảm bảo rằng chúng hoạt động đúng cách.
   - Các công cụ giám sát như Prometheus, Grafana, và ELK stack (Elasticsearch, Logstash, Kibana) thường được sử dụng để thu thập và phân tích dữ liệu giám sát.
   - Giai đoạn này giúp phát hiện sớm các vấn đề và đảm bảo rằng ứng dụng luôn ở trạng thái sẵn sàng.

Pipeline trong CI/CD giúp tối ưu hóa quy trình phát triển phần mềm bằng cách tự động hóa các bước quan trọng và đảm bảo rằng mọi thay đổi đều được kiểm tra và triển khai một cách nhất quán. Điều này giúp giảm thiểu rủi ro, tăng tốc độ phát triển và cải thiện chất lượng phần mềm.

### 1.7. GitOps

GitOps là một phương pháp quản lý cơ sở hạ tầng và ứng dụng bằng cách sử dụng Git như một nguồn sự thật duy nhất. GitOps tận dụng các công cụ và quy trình CI/CD để tự động hóa việc triển khai và quản lý hệ thống. Dưới đây là một số lợi ích chính của GitOps:

1. **Quản lý phiên bản**: GitOps cho phép quản lý phiên bản của toàn bộ cơ sở hạ tầng và ứng dụng. Mọi thay đổi đều được ghi lại trong lịch sử commit của Git, giúp dễ dàng theo dõi và quay lại phiên bản trước nếu cần.

2. **Tự động hóa triển khai**: GitOps tự động hóa quy trình triển khai bằng cách sử dụng các công cụ CI/CD để áp dụng các thay đổi từ Git vào môi trường thực tế. Điều này giúp giảm thiểu sai sót do con người và tăng tốc độ phát hành phần mềm.

3. **Tăng cường bảo mật**: GitOps đảm bảo rằng chỉ những thay đổi đã được phê duyệt mới được triển khai, từ đó nâng cao tính bảo mật cho hệ thống. Mọi thay đổi đều phải thông qua quy trình kiểm tra và phê duyệt trước khi được áp dụng.

4. **Khả năng khôi phục nhanh chóng**: Trong trường hợp xảy ra sự cố, GitOps cho phép khôi phục nhanh chóng về trạng thái trước đó bằng cách sử dụng các commit trong Git. Điều này giúp giảm thiểu thời gian ngừng hoạt động và đảm bảo tính liên tục của dịch vụ.

5. **Cải thiện khả năng hợp tác**: GitOps khuyến khích sự hợp tác giữa các nhóm phát triển và vận hành. Mọi thay đổi đều được thực hiện thông qua quy trình Git, giúp mọi người dễ dàng theo dõi và hiểu rõ các thay đổi trong hệ thống.

6. **Tính nhất quán và đáng tin cậy**: GitOps đảm bảo rằng mọi thay đổi đều được áp dụng một cách nhất quán và đáng tin cậy. Các công cụ CI/CD sẽ tự động kiểm tra và triển khai các thay đổi, giúp giảm thiểu rủi ro và đảm bảo tính ổn định của hệ thống.

GitOps là một phư��ng pháp mạnh mẽ giúp tối ưu hóa quy trình quản lý cơ sở hạ tầng và ứng dụng. Bằng cách sử dụng Git như một nguồn sự thật duy nhất và tự động hóa quy trình triển khai, GitOps giúp cải thiện tính bảo mật, khả năng khôi phục, và khả năng hợp tác giữa các nhóm.

### 1.8. Branching Strategy

Branching Strategy là một phần quan trọng trong version control workflow, đặc biệt khi áp dụng các phương pháp GitOps, DevOps và CI/CD. Chiến lược phân nhánh giúp quản lý và tổ chức source code một cách hiệu quả, đảm bảo rằng các changes được review và deploy một cách nhất quán và an toàn.

Một số branching strategies phổ biến bao gồm:

1. **Feature Branching**: Mỗi feature mới được phát triển trên một dedicated branch. Khi feature hoàn thành và pass qua code review và automated tests, branch này sẽ được merge vào main branch thông qua pull request hoặc merge request.

2. **Release Branching**: Khi chuẩn bị release một version mới, một release branch được tạo ra từ main branch. Branch này chỉ chứa các bug fixes và release-specific changes, không bao gồm các features đang trong development.

3. **Hotfix Branching**: Khi cần fix critical bugs trong production version, một hotfix branch được tạo ra từ main branch hoặc release branch. Sau khi bug được fix và tested, branch này sẽ được merge back vào cả main và release branches.

4. **GitFlow**: Một complex branching strategy bao gồm các long-lived branches (main/master và develop) và các short-lived branches (feature, release, và hotfix). GitFlow phù hợp với các projects có scheduled release cycles.

5. **Trunk-Based Development**: Tất cả các thay đổi được thực hiện trực tiếp trên nhánh chính. Các nhánh ngắn hạn có thể được tạo ra cho các tính năng hoặc sửa lỗi, nhưng chúng sẽ được hợp nhất trở lại vào nhánh chính càng sớm càng tốt.

Chiến lược phân nhánh phù hợp sẽ giúp tối ưu hóa quy trình phát triển phần mềm, giảm thiểu xung đột mã nguồn và đảm bảo rằng các thay đổi được triển khai một cách nhất quán và an toàn.