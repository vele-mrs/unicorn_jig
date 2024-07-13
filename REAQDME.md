# Wiki.md

---
### 開発環境
|||
|---|---|
|Vivado | 2021.2|
|Part|xc7a35ticsg324-1L|
|Memory|s25fl128sxxxxxx0-spi-x1_x2_x4|



<br>
<br>

---
### Tclコマンド

|内容|コマンド|
|---|---|
|カレントディレクトリの確認|pwd|
|ディレクトリの移動|cd ../../../../Desktop/Workspace/Project_FPGA/unicorn_jig/|
|プロジェクトの書き出し|write_project_tcl create_proj.tcl|
|tclファイルの読み込み|source ./create_proj.tcl

<br>
<br>

---
### gitコマンド

|内容|コマンド|
|---|---|
|カレントディレクトリの確認|pwd|
|git初期化|git init|
|リモートリポジトリをローカルリポジトリに追加|git remote add origin ***|
|現在のリポジトリの状態を確認する|git status|
|変更されたファイルをステージングエリアに追加|git add * |
|ステージングエリアにある変更をコミット|git commit -m "***"|
|ローカルリポジトリの main ブランチの変更をリモートリポジトリの origin に送信|git push origin main|
