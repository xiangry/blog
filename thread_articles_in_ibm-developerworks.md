[IBM developerWorks 线程文章汇总](http://zengrong.net/post/2163.htm)

最早我在 [POSIX線程(pthread)入門文章分享][1] 看到了关于 IBM developerWorks 中线程文章的一些汇总。但是按照该文中提供的链接一一找去，发现均不能访问。

原来 IBM developerWorks 对目录结构进行了修改，因此原来的链接就都作废了。

由于找不到 IBM developerWorks 中的相关汇总页面，我就人肉汇总了一次。

原文中只有 C 和 C++ 部分的内容，我又加入了 Python 和 HTML5 的内容。

下文的繁体字内容来自 [POSIX線程(pthread)入門文章分享][1]。<!--more-->

# POSIX线程

POSIX 表示可移植操作系統接口（Portable Operating System Interface ，縮寫為 POSIX 是為了讀音更像 UNIX）。電氣和電子工程師協會（Institute of Electrical and Electronics Engineers，IEEE）最初開發 POSIX 標準，是為了提高 UNIX 環境下應用程序的可移植性。具體的說 POSIX 是 IEEE 為要在各種 UNIX 操作系統上運行的軟件定義 API 所規定的一系列互相關聯的標準的總稱，而 X 則表明其對 Unix API 的傳承。Linux 基本上逐步實現了 POSIX 兼容，但並沒有參加正式的 POSIX 認證。當前的 POSIX 文檔分為三個部分：POSIX Kernel API，POSIX 命令和工具集，及 POSIX 一致性測試。Posix 線程（POSIX threads，又稱 Pthreads）是負責 POSIX 的 IEEE 委員會開發的一套線程接口。

## 中文版

* [pthreads 的基本用法-介绍POSIX线程][5]

## 英文版

* [Basic use of pthreads-An introduction to POSIX threads][17]

# POSIX 线程详解

Daniel Robbins 從實例入手，逐步講解 POSIX thread 編程技巧，有共享內存、互斥以及條件變量的運用。

## 中文版本

* [(1)一种支持内存共享的简捷工具][3]
* [(2)称作互斥对象的小玩意][4]
* [(3)使用条件变量提高效率][11]

## 英文版本

* [POSIX threads explained][13]
* [Common threads: POSIX threads explained, Part 2][14]
* [Common threads: POSIX threads explained, Part 3][15]

# Posix线程编程指南

* [(1)线程的创建和取消][6]
* [(2)线程私有数据][7]
* [(3)线程同步][8]
* [(4)线程终止][9]
* [(5)杂项][10]
 
# pthread 内存泄露

## 中文版

[在 POSIX 线程编程中避免内存泄漏][23]

## 英文版

* [Avoiding memory leaks in POSIX thread programming][16]

# 其它 pthread

* [Pthreads arguments passing][18]
* [POSIX Threads Programming][19]
* [POSIX thread (pthread) libraries][20]

# Linux线程模型

Linux 最初用的線程模型是 LinuxThread, 它不兼容 POSIX，而且存在一些性能問題，所以目前 Linux 摒棄了它，採用了基於 Pthreads 的 NPTL（Native POSIX Threads Library for Linux）模型， NPTL 修復了 LinuxThread 的許多缺點，並提供了更好的性能。

* [Linux 线程模型的比较：LinuxThreads 和 NPTL][2]
* [Linux线程实现机制分析][5]
* [Linux 线程库性能测试与分析][12]

# HTML5

[深入 HTML5 Web Worker 应用实践：多线程编程][21]

# Python

* [使用 Python 进行线程编程][22]
* [使用 Python 实现多进程][24]


[1]: http://dragonspring.pixnet.net/blog/post/32963482-posix%E7%B7%9A%E7%A8%8B%28pthread%29%E5%85%A5%E9%96%80%E6%96%87%E7%AB%A0%E5%88%86%E4%BA%AB
[2]: http://www.ibm.com/developerworks/cn/linux/l-threading.html
[3]: http://www.ibm.com/developerworks/cn/linux/thread/posix_thread1/
[4]: http://www.ibm.com/developerworks/cn/linux/thread/posix_thread2/
[11]: http://www.ibm.com/developerworks/cn/linux/thread/posix_thread3/
[5]: http://www.ibm.com/developerworks/cn/linux/l-pthred/
[6]: http://www.ibm.com/developerworks/cn/linux/thread/posix_threadapi/part1/
[7]: http://www.ibm.com/developerworks/cn/linux/thread/posix_threadapi/part2/
[8]: http://www.ibm.com/developerworks/cn/linux/thread/posix_threadapi/part3/
[9]: http://www.ibm.com/developerworks/cn/linux/thread/posix_threadapi/part4/
[10]: http://www.ibm.com/developerworks/cn/linux/thread/posix_threadapi/part5/
[12]: http://www.ibm.com/developerworks/cn/linux/l-nptl/
[13]: http://www.ibm.com/developerworks/linux/library/l-posix1/
[14]: http://www.ibm.com/developerworks/linux/library/l-posix2/
[15]: http://www.ibm.com/developerworks/linux/library/l-posix3/
[16]: http://www.ibm.com/developerworks/linux/library/l-memory-leaks/
[17]: http://www.ibm.com/developerworks/linux/library/l-pthred/
[18]: http://www.domaigne.com/blog/computing/pthreads-arguments-passing/
[19]: https://computing.llnl.gov/tutorials/pthreads/
[20]: http://www.yolinux.com/TUTORIALS/LinuxTutorialPosixThreads.html
[21]: http://www.ibm.com/developerworks/cn/web/1112_sunch_webworker/
[22]: http://www.ibm.com/developerworks/cn/aix/library/au-threadingpython/
[23]: http://www.ibm.com/developerworks/cn/linux/l-memory-leaks/
[24]: http://www.ibm.com/developerworks/cn/aix/library/au-multiprocessing/
