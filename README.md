# 異質使用者密度分布應用環境下最大化滿足率之無人機佈署演算法

本 repository 包含 SPIRAL+、逆時針螺旋、kmeans、隨機、voronoi 五種部署演算法及各項指標分析的 matlab 檔，以及一個使用 matlabengine 串接的模擬平台。 

## 模擬平台啟動

模擬平台使用`Python`撰寫，使用方式如下：

1. 請確認是否安裝 Python
    ```
    python --version
    ```

2. Python 安裝依賴套件
    ```
    pip install Flask
    pip install matlabengine 
    ```

3. 啟動後端
   ```
   python ./emulator.py
   ```

5. 啟動瀏覽器 [localhost:8088](localhost:8088)

## 模擬平台開發模式

模擬平台開發模式使用`Python`及`Node.js`撰寫，使用`Next.js 14.0.4`框架與`NextUI`套件，使用方式如下：

1. 請確認是否安裝 Python 及 Node.js
    ```
    node --version
    python --version
    ```
    [!NOTE]
    Next.js 14 要求 Node.js 版本要高於 18.17

2. Python 安裝依賴套件
    ```
    pip install Flask
    pip install Flask-Cors
    pip install matlabengine
    ```

3. Next.js 安裝依賴套件
    ```
    npm install
    ```

4. 啟動後端
   ```
   python ./emulator.py
   ```

5. 啟動前端
   ```
   cd ./emulator/
   npm run dev
   ```

6. 啟動瀏覽器 [localhost:3000](localhost:3000)


## 模擬器
![模擬器1](https://github.com/PMinn/Deployment-of-UAV-BSs/blob/main/images/1.jpg?raw=true)
![模擬器2](https://github.com/PMinn/Deployment-of-UAV-BSs/blob/main/images/2.jpg?raw=true)
![模擬器3](https://github.com/PMinn/Deployment-of-UAV-BSs/blob/main/images/3.jpg?raw=true)
![模擬器4](https://github.com/PMinn/Deployment-of-UAV-BSs/blob/main/images/4.jpg?raw=true)