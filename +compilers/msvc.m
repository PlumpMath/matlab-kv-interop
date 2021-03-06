%% compilers.msvc
% Visual C++でコンパイルを行うための関数
% 複数のバージョンがインストールされているときは最新のを使う

function [status, output] = msvc (sources, executable)

%%
% 引数

% sources    : ソースファイルのセル配列
% executable : 実行ファイル名(省略可)

%%
% 戻り値

% status : コンパイラの終了コード(0のときコンパイル成功)
% output : コンパイラの標準出力

%% Visual Studioを探す
% |tools\get-vs-path.bat|を使って最新のVisual Studioのインストール先を探す

%%
% <html><h3><tt>tools\get-vs-path.bat</tt>の動作</h3></html>

% ・VS(数字)0COMNTOOLSという名前の環境変数を探す
%   ・(数字)にはVisual Studioのバージョン番号が入る
%   ・(数字)を100から9まで変化させて最初に見つかったものを使う
%     ・もっと賢い実装にしたい
% ・VS(数字)0COMNTOOLSが指すディレクトリ内のvsvars32.batを実行する
% ・vsvars32.batを実行するとVSINSTALLDIR環境変数にVisual Studioのインストール先が設定されるので、
%   VSINSTALLDIR環境変数の中身を標準出力に書き出す

%%
% <html><h3>プログラム</h3></html>

persistent msvc_dir

if ~ischar(msvc_dir)
    [status, output] = system(fullfile('tools', 'get-vs-path.bat'));

    if status ~= 0 || isempty(output)
        error('Visual C++ not found.');
    end

    msvc_dir = fullfile(output(1:end-1), 'VC');
end

%% コンパイル
% |vcvarsall.bat|を実行した後に |cl| を実行してコンパイルする

if strcmp(getenv('PROCESSOR_ARCHITECTURE'), 'AMD64')
    arch = 'amd64';
else
    arch = 'x86';
end

command = [ ...
    '"' fullfile(msvc_dir, 'vcvarsall.bat') '" ' arch ...
    ' && cl /Ox /EHsc /MT /DNDEBUG /I.\include' ...
];

first = length(command) + 1;

command = [ ...
    command ...
    zeros(1, sum(cellfun(@(x) length(x), sources)) ...
             + length(sources)) ...
];

for i = 1:length(sources)
    source = char(sources(i));
    
    last = first + length(source);
    command(first) = ' ';
    command(first + 1 : last) = source;
    first = last + 1;
end

if nargin >= 2
    command = [command ' /Fe' executable];
end

[status, output] = system(command);

end