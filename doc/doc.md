




環境：Vivado 2021.2




Tclコマンド

pwd
カレントディレクトリの確認

cd ../../../../Desktop/Workspace/Project_FPGA/unicorn_jig/
ディレクトリの移動

write_project_tcl create_proj.tcl
プロジェクトの書き出し

source ./create_proj.tcl
tclファイルの読み込み

gitコマンド
git init
git remote add origin https://github.com/vele-mrs/unicorn_jig.git
git status
git add *
git commit -m "init"
git push origin main
