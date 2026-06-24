import os
import sys
import shutil
import argparse
import subprocess
from datetime import datetime

# Configuration
RESULTS_DIR = "results"
TESTS_DIR = "tests"

def clean_results():
    if os.path.exists(RESULTS_DIR):
        print(f"[*] Đang dọn dẹp thư mục báo cáo cũ '{RESULTS_DIR}'...")
        # Chỉ xóa các file html và xml, giữ lại screenshots nếu cần, hoặc xóa hết
        for filename in os.listdir(RESULTS_DIR):
            file_path = os.path.join(RESULTS_DIR, filename)
            try:
                if os.path.isfile(file_path) or os.path.islink(file_path):
                    os.unlink(file_path)
                elif os.path.isdir(file_path):
                    shutil.rmtree(file_path)
            except Exception as e:
                print(f"[!] Lỗi khi xóa {file_path}. Lý do: {e}")
    else:
        os.makedirs(RESULTS_DIR, exist_ok=True)
    print("[*] Đã dọn dẹp xong!")

def run_tests(suite, headless, tags):
    print(f"[*] Bắt đầu tiến trình Automation Testing...")
    
    cmd = ["robot", "-d", RESULTS_DIR]
    
    if headless:
        cmd.extend(["--variable", "HEADLESS:True"])
        print("[*] Chế độ: Headless (Chạy ngầm không mở trình duyệt)")
    else:
        print("[*] Chế độ: UI (Hiển thị trình duyệt)")
        
    if tags:
        cmd.extend(["-i", tags])
        print(f"[*] Chạy các test case có gắn Tag: {tags}")
        
    if suite:
        # Nếu người dùng nhập "login", tự động đổi thành "LoginTests.robot"
        original_suite = suite
        if not suite.lower().endswith(".robot"):
            if not suite.lower().endswith("tests"):
                suite += "Tests"
            suite += ".robot"
            
        # Chữ cái đầu viết hoa
        suite = suite[0].upper() + suite[1:]
        target = os.path.join(TESTS_DIR, suite)
        
        if not os.path.exists(target):
             print(f"[!] Lỗi: Không tìm thấy kịch bản test '{target}'!")
             sys.exit(1)
        cmd.append(target)
        print(f"[*] Mục tiêu: {target}")
    else:
        cmd.append(TESTS_DIR)
        print(f"[*] Mục tiêu: Chạy TẤT CẢ các chức năng (Full Suite)")
        
    print(f"[*] Lệnh thực thi: {' '.join(cmd)}")
    print("=" * 60)
    
    start_time = datetime.now()
    result = subprocess.run(cmd)
    end_time = datetime.now()
    
    print("=" * 60)
    print(f"[*] Quá trình test hoàn tất trong: {end_time - start_time}")
    if result.returncode == 0:
        print("[*] Kết quả: THÀNH CÔNG (100% Pass) 🎉")
    else:
        print(f"[!] Kết quả: CÓ LỖI (Vui lòng xem file Report) ❌")
        
    print(f"[*] Báo cáo (Report) đã được xuất tại: {os.path.abspath(os.path.join(RESULTS_DIR, 'report.html'))}")
    sys.exit(result.returncode)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Custom CLI Runner for Homestay Booking Automation")
    parser.add_argument("-s", "--suite", help="Ten luong chuc nang muon test (VD: login, adminRoom, search)", default=None)
    parser.add_argument("--headless", action="store_true", help="Kich hoat che do chay ngam (Khong mo GUI Chrome)")
    parser.add_argument("-t", "--tags", help="Chay test theo cac tag cu the", default=None)
    parser.add_argument("--no-clean", action="store_true", help="Giu lai report va anh chup man hinh cu")
    
    args = parser.parse_args()
    
    print("=" * 60)
    print("   HOMESTAY BOOKING - AUTOMATION CUSTOM CLI RUNNER")
    print("=" * 60)
    
    if not args.no_clean:
        clean_results()
        
    run_tests(args.suite, args.headless, args.tags)
