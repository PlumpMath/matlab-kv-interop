# MATLAB-kv-interop

`make_kv_qr_lohner.m`と`kv_qr_lohner.m`はしばらく触ってないので正しく動作しない。

## 使い方

MATLABからこのディレクトリを開けば使うことができるので、インストールに特別な操作は必要ない。
アンインストールも単にこのディレクトリを削除するだけで良い。

使い方は`sample_make_maffine2_lorenz.m`などを見れば分かると思う。
`sample_make_maffine2_lorenz_nosyms.m`にSymbolic Math Toolboxに依存せずに関数を作る方法の例がある。

## ファイル一覧

あまり重要でないファイル以外は`html`ディレクトリ以下に詳しい説明がある。

* `+compilers`  
  コンパイラをラップした関数を集めたディレクトリ  
  いずれもソースファイルのセル配列と出力ファイル名を受け取って終了ステータスと出力を返す  
  コンパイラは事前にインストールしておく
  * `clang.m`  
    Clangをラップした関数
  * `gcc.m`  
    GCCをラップした関数
  * `msvc.m`  
    Visual C++をラップした関数
* `+tools`  
  MATLABからC++のプログラムを実行するために必要な関数を集めたディレクトリ
  * `build_tools.m`  
    `tools`以下にあるツールをビルドする関数
  * `detect_compiler.m`  
    コンパイラを探して、見つけたコンパイラに対応する`+compilers`ディレクトリ内の関数を返す
  * `get_last_result.m`  
    生成したプログラムの最新の実行結果を得る関数
  * `prepare.m`  
    `make_kv_*`がプログラムをコンパイルするための準備を行う関数
* `include`  
  C++のプログラムのコンパイルに必要なヘッダ群
* `tools`  
  C++のプログラムを生成するために必要なプログラムを集めたディレクトリ
* `kv_maffine2.m`  
  `make_kv_maffine2`で生成したプログラムを実行して計算結果を返す
* `kv_qr_lohner.m`  
  `make_kv_qr_lohner`で生成したプログラムを実行して計算結果を返す
* `make_kv_maffine2.m`  
  `kv::ode_maffine2`を使って計算するプログラムを生成する  
  `t`の分割数を指定できる
* `make_kv_qr_lohner.m`  
  `kv::odelong_qr_lohner`を使って計算するプログラムを生成する  
  `t`の分割数は指定できない
* `Status.m`  
  `kv_maffine2`で計算ができたかどうかを表す列挙型
