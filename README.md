# IGRF (13th gen.) を C++ で呼び出す

# インストール

1. Makefile中の変数 PREFIX をインストールしたい場所に書き換える。
 (そのままであればホームディレクトリとなる)

2. make; make install

3. make test
 実行ファイル test ができるので、動作を確認する

# 使用法

## プログラムソース
```C++:example
#include <geomag.h>

int main(void){
  int Year  { 2021 };
  int Month {    8 };
  int Day   {   15 };
  double Altitude_in_km { 90.0 };
  double Latitude_in_deg { 35.656 }; /* +90 〜 -90 */
  double Longitude_in_deg { 139.544 }; /* -180 〜 +180, 負は西経 */
  double Declination_in_deg;
  double Inclination_in_deg;
  double Total_Intensity_in_nT;

  calc_geomagnetic_field(Year, Month, Day,
    Altitude_in_km, Latitude_in_deg, Longitude_in_deg,
    Declination_in_deg, Inclination_in_deg, Total_Intensity_in_nT);
```

## コンパイル
```Tcsh:
% g++ -c main.cpp -I/home/XXX/include
% g++ -o main main.o -Wl,-R/home/XXX/lib -L/home/XXXlib -ligrf_YY
```
XXX はホームディレクトリ名、_YY はライブラリのコンパイル時のサフィクス
