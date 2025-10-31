# AES_UART_Interface_testsystem

DE1-SoC | Quatus prime lite edition 24.1 | Modelsim Intel FPGA starter edition

Đây là đồ án tốt nghiệp của nhóm tôi, hiện tại đây là bản đã chạy mô phỏng trên Modelsim cho ra các trường hợp lý tưởng. Mục đích chính là dùng UART để có thể debug và hỗ trợ lúc bảo vệ đồ án, đây cũng là một bản backup cho các thay đổi lớn sắp tới khi tôi sử dụng thêm HPS.
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

