# 異質使用者密度分布應用環境下最大化滿足率之無人機佈署演算法 #

本 repository 包含 SPIRAL+、逆時針螺旋、kmeans、隨機、voronoi 五種部署演算法及各項指標分析的 matlab 檔，以及一個使用 matlabengine 串接的模擬平台。 

## 模擬平台 ##

模擬平台使用`Python`及`Node.js`撰寫，使用方式如下：

1. 請確認是否安裝 Python 及 Node.js
    ```
    node --version
    python --version
    ```

2. Python 安裝依賴套件
    ```
    pip install Flask
    pip install Flask-Cors
    pip install matlabengine 
    ```

3. 啟動後端
   ```
   python ./emulator.py
   ```

4. 啟動前端
   ```
   node ./emulator/?.js
   ```

5. 啟動瀏覽器 [localhost:3000](localhost:3000)