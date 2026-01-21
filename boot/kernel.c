// kernel.c - C语言内核主函数 (彩色显示)
void clear_screen() {
    char* video_memory = (char*)0xB8000;
    int i;
    for(i = 0; i < 4000; i++) { // 80*25*2 = 4000 bytes
        video_memory[i] = 0;
    }
}

void print_at(char* str, int row, int col, char attr) {
    char* video_memory = (char*)0xB8000;
    int pos = (row * 80 + col) * 2; // 每个字符占2字节
    
    int i = 0;
    while(str[i] != '\0') {
        video_memory[pos] = str[i];
        video_memory[pos+1] = attr;
        pos += 2;
        i++;
    }
}

void kmain()
{
    // 清屏
    clear_screen();
    
    // 显示彩色信息
    print_at("KERNEL LOADING...", 1, 10, 0x0A);     // 绿色
    print_at("STATUS: OK", 3, 10, 0x09);            // 浅蓝色
    print_at("VERSION: 1.0", 4, 10, 0x0E);          // 黄色
    print_at("READY FOR INPUT", 6, 10, 0x0C);       // 浅红色
    print_at("SYSTEM ONLINE", 8, 10, 0x0F);         // 白色
    
    // 彩虹条纹
    int i;
    char rainbow[] = {'R', 'A', 'I', 'N', 'B', 'O', 'W'};
    char colors[] = {0x0C, 0x0E, 0x0A, 0x0B, 0x09, 0x0D, 0x0F}; // 不同颜色
    
    for(i = 0; i < 7; i++) {
        char temp[2] = {rainbow[i], '\0'};
        print_at(temp, 12, 30+i, colors[i]);
    }
    
    // 停机循环
    while(1) {
        __asm__("hlt");
    }
}

