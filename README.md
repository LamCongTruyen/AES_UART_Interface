# AES_UART_Interface_testsystem

DE1-SoC | Quatus prime lite edition 24.1 | Modelsim Intel FPGA starter edition

Đây là đồ án tốt nghiệp của nhóm tôi, bên dưới là hình ảnh các mô phỏng trên Modelsim cho ra các trường hợp lý tưởng. Mục đích chính là dùng UART để có thể debug và hỗ trợ lúc bảo vệ đồ án, đây cũng là một bản backup cho các thay đổi lớn sắp tới khi tôi sử dụng thêm HPS.
Các module chính trong toàn bộ dự án :

<img width="295" height="148" alt="image" src="https://github.com/user-attachments/assets/194bbbfc-5c6b-44ac-8a53-05a53ccfe6be" />

Top level là module 'aes_uart_top: shakehand 3 module con là AES_CTR_pipelined, uart_rx_top, aes_to_tx_top. Trong đó:
Module AES_CTR_pipelined: là module chính thực hiện mã hóa AES_ctr
Module uart_rx_top: vì 'AES_CTR_pipelined' mất 11clk từ lúc nhận plaintext và xuất ra ciphertext đây là một tốc độ rất nhanh so với giao thức căn bản UART. Vì thế uart_rx_top thực hiện handshake giữa cổng input RX với  128bit plaintext input của AES_CTR_pipelined. Module này tôi sử dụng bộ đệm 2048byte.
Module aes_to_tx_top: module này thực hiện handshake cổng output 128bit ciphertext của AES_CTR_pipelined với data input 8bit của uart_tx.

Các trạng thái mô phỏng của từng module được tôi sử dụng AI hỗ trợ viết các trường hợp mô phỏng căn bản như sau:

Testbench module aes_uart_top:

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/acb56238-a5a8-4c69-8d71-4a13038a8e8c" />

Testbench module AES_CTR_pipelined:

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/4f4533f4-1772-4e6b-ac60-43328a967ee4" />

 Testbench module uart_rx_top:

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/3e7bc9aa-e450-4c4c-9fcd-3bd3474e2f06" />

 Testbench module aes_to_tx_top:

 <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/ae5009ce-2162-46d4-a9bd-77b7999a1de3" />

Testbench module uart_rx:

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/46cbbca3-0e12-4327-a551-a2c654a91867" />

Testbench module uart_tx:

<img width="1912" height="1076" alt="image" src="https://github.com/user-attachments/assets/280dfe99-65d2-4f5b-9119-171ba16e332e" />

Nhóm hai người bọn tôi chọn Winform làm giao diện cho giao tiếp truyền nhận plaintext và ciphertext, mặc dù nó không phải là một giao thức cho tốc độ nhanh nhưng nó là giao thức căn bản nhất. Việc thực hiện chi tiết một core UART và handshake được các module là nền tảng giúp hiểu các giao thức phức tạp khác.

Dưới đây là hình ảnh giao diện winform hiển thị dữ liệu hình ảnh được resize về 64x64 và chuyển thành mảng byte sau đó gửi xuống FPGA qua UART. Sau đó winform nhận cipher, thực hiện ngược lại thao tác ta nhận lại plaintext ban đầu. Sau khi chuyển mảng byte thành ảnh thì có thể thấy hình ảnh trùng khớp với các hình ảnh ban đầu.

<img width="1133" height="767" alt="image" src="https://github.com/user-attachments/assets/7d1a42c4-b43e-4bf3-93ce-b534d01365d7" />

Sau một vài ngày kiểm tra chức năng thì với các chức năng cơ bản như trên thì hệ thống hoạt động chính xác, tuy nhiên với hình ảnh chất lượng cao thì việc truyền nhận có thể bị ngẽn. Tôi sẽ sử dụng thêm HPS trên DE1-SOC cho dự án này để hỗ trợ cải thiện tốc độ và dung lượng hình ảnh lớn hơn.

Tiếp tới nhóm 2 thành viên bọn tôi sẽ tiếp tục phát triển trên DE1-SoC cho phép mã hóa video stream.

Những dòng cuối này thì tôi muốn khẳng định rằng là việc dùng uart (1 giao thức rất cơ bản) cho việc truyền dữ liệu ảnh như này nó rất là nhiều vấn đề về tính thực tế, hiệu suất cũng như là đảm bảo tín hiệu với dữ liệu lớn. Điều tôi muốn nhấn mạnh với dự án này ở thời điểm hiện tại (khi chưa tích hợp với HPS trên DE1-SoC) nó sẽ mang tính học thuật cao hơn. Phần lớn thời gian tôi dành vào việc hiểu frame data của UART dựa vào đó để viết Statemachine và việc chiếm nhiều thời gian nhất đó là xác minh từng module trước khi kết nối chúng lại với nhau. Việc chạy testbench từng module nhỏ cho ra dạng sóng ưng ý nhưng khi kết nối chúng lại, đôi khi việc bắt tay không tốt nên thực tế trên phần cứng nó hoạt động không chính xác như trên testbench và tôi mất khá nhiều thời gian chỉnh sửa FSM để UART có thể truyền ciphertext và nhận plaintext một cách chính xác nhất.
